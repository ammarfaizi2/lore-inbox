Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129240AbRCBP22>; Fri, 2 Mar 2001 10:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129242AbRCBP2S>; Fri, 2 Mar 2001 10:28:18 -0500
Received: from adsl-63-205-85-133.dsl.snfc21.pacbell.net ([63.205.85.133]:62990
	"EHLO schmee.sfgoth.com") by vger.kernel.org with ESMTP
	id <S129240AbRCBP2M>; Fri, 2 Mar 2001 10:28:12 -0500
Date: Fri, 2 Mar 2001 07:27:52 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Miguel Armas <kuko@ulpgc.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.2 SMP + ATM hangs
Message-ID: <20010302072752.A96455@sfgoth.com>
In-Reply-To: <Pine.LNX.4.21.0103021349450.4667-100000@mento.ulpgc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.21.0103021349450.4667-100000@mento.ulpgc.es>; from kuko@ulpgc.es on Fri, Mar 02, 2001 at 02:34:35PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Armas wrote:
> A couple days ago we installed a Fore 200E ATM card and after getting the
> ATM address using ilmid the machine hangs. The kernel still respond to
> pings, but the userspace is dead.
> 
> If we remove SMP support in the kernel everything works fine (but with
> only one CPU)...

You probably need the patch that Chas Williams came up with in January.
I've been meaning to forward it, but I haven't yet.  Please try it and
see if it fixes your problem.

-Mitch

--- net/atm/addr.c.000  Thu Jan 25 16:26:24 2001
+++ net/atm/addr.c      Thu Jan 25 16:26:10 2001
@@ -57,7 +57,6 @@
 {
        struct atm_dev_addr *this;
 
-       spin_lock (&atm_dev_lock);
        down(&local_lock);
        while (dev->local) {
                this = dev->local;
@@ -65,7 +64,6 @@
                kfree(this);
        }
        up(&local_lock);
-       spin_unlock (&atm_dev_lock);
        notify_sigd(dev);
 }
