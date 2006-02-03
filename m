Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWBCBrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWBCBrH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 20:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWBCBrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 20:47:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47329 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964834AbWBCBrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 20:47:04 -0500
Date: Thu, 2 Feb 2006 20:46:45 -0500
From: Dave Jones <davej@redhat.com>
To: Avi Kivity <avi@argo.co.il>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: discriminate single bit error hardware failure from slab corruption.
Message-ID: <20060203014645.GD10209@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Avi Kivity <avi@argo.co.il>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060202192414.GA22074@redhat.com> <43E2A784.2070809@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E2A784.2070809@argo.co.il>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 02:44:52AM +0200, Avi Kivity wrote:

 >         total += hweight8(data[offset+i] ^ POISON_FREE);
 > 
 > >		printk(" %02x", (unsigned char)data[offset + i]);
 > >	}
 > >	printk("\n");
 > >@@ -1019,6 +1023,18 @@ static void dump_line(char *data, int of
 > >		}
 > >	}
 > >	printk("\n");
 > >+	switch (total) {
 > >+		case 0x36:
 > >+		case 0x6a:
 > >+		case 0x6f:
 > >+		case 0x81:
 > >+		case 0xac:
 > >+		case 0xd3:
 > >+		case 0xd5:
 > >+		case 0xea:
 > >+			printk (KERN_ERR "Single bit error detected. 
 > >Possibly bad RAM. Please run memtest86.\n");
 > >+			return;
 > >+	}
 > > 
 > >
 > and a
 > 
 >     if (total == 1)
 >           printk(...);
 > 
 > here? it seems more readable and more correct as well.

More readable ? Are you kidding ?
What I wrote is smack-you-in-the-face-obvious what it's doing.
With your variant, I have to sit down and think it through.

wrt correctness, what do you see wrong with my approach?

		Dave

