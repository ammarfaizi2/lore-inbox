Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267041AbSKMAIm>; Tue, 12 Nov 2002 19:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267045AbSKMAIm>; Tue, 12 Nov 2002 19:08:42 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:16651 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267041AbSKMAIk>; Tue, 12 Nov 2002 19:08:40 -0500
Date: Wed, 13 Nov 2002 00:15:30 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Matthias Urlichs <smurf@noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4: scsi and BLK_STATS
Message-ID: <20021113001530.A323@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthias Urlichs <smurf@noris.de>, linux-kernel@vger.kernel.org
References: <20021112172821.GA14195@play.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021112172821.GA14195@play.smurf.noris.de>; from smurf@noris.de on Tue, Nov 12, 2002 at 06:28:21PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 06:28:21PM +0100, Matthias Urlichs wrote:
> Some people might want SCSI without block statistics...

Probably.  But your patch doesn;t gain them anything but a useless
ifdef..  Look at include/linux/genhd.h:

#ifdef CONFIG_BLK_STATS
extern void disk_round_stats(struct hd_struct *hd);
extern void req_new_io(struct request *req, int merge, int sectors);
extern void req_merged_io(struct request *req);
extern void req_finished_io(struct request *req);
#else
static inline void req_new_io(struct request *req, int merge, int sectors) { }
static inline void req_merged_io(struct request *req) { }
static inline void req_finished_io(struct request *req) { }
#endif /* CONFIG_BLK_STATS */

