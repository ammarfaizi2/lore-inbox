Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267084AbSKMBY0>; Tue, 12 Nov 2002 20:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267086AbSKMBY0>; Tue, 12 Nov 2002 20:24:26 -0500
Received: from mail3.noris.net ([62.128.1.28]:32648 "EHLO mail3.noris.net")
	by vger.kernel.org with ESMTP id <S267084AbSKMBYW>;
	Tue, 12 Nov 2002 20:24:22 -0500
From: "Matthias Urlichs" <smurf@noris.de>
Date: Wed, 13 Nov 2002 02:30:59 +0100
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4: scsi and BLK_STATS
Message-ID: <20021113023059.K18881@noris.de>
References: <20021112172821.GA14195@play.smurf.noris.de> <20021113001530.A323@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021113001530.A323@infradead.org>; from hch@infradead.org on Wed, Nov 13, 2002 at 12:15:30AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Christoph Hellwig:
> On Tue, Nov 12, 2002 at 06:28:21PM +0100, Matthias Urlichs wrote:
> > Some people might want SCSI without block statistics...
> 
> Probably.  But your patch doesn;t gain them anything but a useless
> ifdef..  Look at include/linux/genhd.h:
> 
*Sigh*
Note that scsi_lib.c does not include linux/genhd.h, thus I missed
that. :-/

> static inline void req_new_io(struct request *req, int merge, int sectors) { }
> static inline void req_merged_io(struct request *req) { }
> static inline void req_finished_io(struct request *req) { }

That may be a matter of style, but I would strongly prefer these to be

#define req_new_io(_a,_b,_c) do {} while(0)
#define req_merge_io(_a)     do {} while(0)
#define req_finished_io(_a)  do {} while(0)

instead ... anyway, please disregard my patch and add

#include <linux/genhd.h>

in scsi/scsi_lib.c.  :-/

-- 
Matthias Urlichs     |     noris network AG     |     http://smurf.noris.de/
