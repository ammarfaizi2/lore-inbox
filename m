Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131347AbRCNNTj>; Wed, 14 Mar 2001 08:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131348AbRCNNT3>; Wed, 14 Mar 2001 08:19:29 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:26051 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S131347AbRCNNTM>; Wed, 14 Mar 2001 08:19:12 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brad Douglas <brad@neruo.com>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [RFC] fbdev & power management
Date: Wed, 14 Mar 2001 14:17:56 +0100
Message-Id: <20010314131756.18036@mailhost.mipsys.com>
In-Reply-To: <E14d6Ee-00009a-00@usw-sf-list1.sourceforge.net>
In-Reply-To: <E14d6Ee-00009a-00@usw-sf-list1.sourceforge.net>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I think registering fbcon as a PM client and doing the above when the
>fbdev suspend/resume hooks are called should work.  A memory backup is
>worked on until the resume is run and the backup is restored to the
>display.
>
>So the fbdev drivers would register PM with fbcon, not PCI, correct?

Either that, or the fbdev would register with PCI (or whatever), _and_
fbcon would too independently. In that scenario, fbcon would only handle
things like disabling the cursor timer, while fbdev's would handle HW
issues. THe only problem is for fbcon to know that a given fbdev is
asleep, this could be an exported per-fbdev flag, an error code, or
whatever. In this case, fbcon can either buffer text input, or fallback
to the cfb working on the backed up fb image (that last thing can be
handled entirely within the fbdev I guess).

Ben.



