Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133006AbRDYXjN>; Wed, 25 Apr 2001 19:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133013AbRDYXjD>; Wed, 25 Apr 2001 19:39:03 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:64774 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S133006AbRDYXip>; Wed, 25 Apr 2001 19:38:45 -0400
Date: Wed, 25 Apr 2001 17:32:10 -0600
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: Re: filp_open() in 2.2.19 causes memory corruption
Message-ID: <20010425173210.A13124@vger.timpanogas.org>
In-Reply-To: <20010423163757.D1131@vger.timpanogas.org> <20010423163248.B1131@vger.timpanogas.org> <001d01c0cc33$7e62daa0$5517fea9@local> <3942.988063428@redhat.com> <20010423163248.B1131@vger.timpanogas.org> <4750.988065680@redhat.com> <20010423163757.D1131@vger.timpanogas.org> <4855.988065927@redhat.com> <20010423163954.A1237@vger.timpanogas.org> <4897.988066047@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <4897.988066047@redhat.com>; from dwmw2@infradead.org on Mon, Apr 23, 2001 at 11:47:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 11:47:27PM +0100, David Woodhouse wrote:

David/LKML,

I've gotten to the bottom of this problem, and you are correct that klog 
is trashing the messages file for the oops.  As for the oops, it was related
to the use of ll_rw_blk() instead of submit_bh() in 2.4.3 which was causing 
memory corruption in Linus' buffer cache code.   In NetWare, we used to 
create a signature field for I/O and other structures that were submitted
by modules other than the media manager.  

This would be useful for the buffer cache to put in a signature field so 
if he ever gets back a buffer head that is not his, the buffer cache 
could drop it with a noisy message rather than have memory corruption 
and other side effects that take days to track down.

Jeff

> 
