Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132605AbRDOIc3>; Sun, 15 Apr 2001 04:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132606AbRDOIcT>; Sun, 15 Apr 2001 04:32:19 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:16335 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132605AbRDOIcF>;
	Sun, 15 Apr 2001 04:32:05 -0400
Message-ID: <3AD95C7F.51E07B36@mandrakesoft.com>
Date: Sun, 15 Apr 2001 04:31:59 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Swivel <swivel@null.pharm.uic.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: small bug/oversight found in 2.4.3
In-Reply-To: <Pine.LNX.4.33.0104150318460.32474-100000@null.cc.uic.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Swivel wrote:
> 
> drivers/char/char.c, line 247
> create_proc_read_entry() is called regardless of the definition of
> CONFIG_PROC_FS, simply wrap call with #ifdef CONFIG_PROC_FS and #endif.

create_proc_read_entry exists, as a static inline no-op, without
CONFIG_PROC_FS.

Typically you want to change the driver-local function passed to
create_proc_read_entry to be a static inline no-op for the
!CONFIG_PROC_FS case.

-- 
Jeff Garzik       | "Give a man a fish, and he eats for a day. Teach a
Building 1024     |  man to fish, and a US Navy submarine will make sure
MandrakeSoft      |  he's never hungry again." -- Chris Neufeld
