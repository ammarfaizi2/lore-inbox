Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268368AbUJDD6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268368AbUJDD6G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 23:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUJDD6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 23:58:06 -0400
Received: from jade.aracnet.com ([216.99.193.136]:28830 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S268368AbUJDD6D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 23:58:03 -0400
Date: Sun, 03 Oct 2004 20:56:40 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Paul Jackson <pj@sgi.com>
cc: pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <838090000.1096862199@[10.10.2.4]>
In-Reply-To: <20041003175309.6b02b5c6.pj@sgi.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com><20040805190500.3c8fb361.pj@sgi.com><247790000.1091762644@[10.10.2.4]><200408061730.06175.efocht@hpce.nec.com><20040806231013.2b6c44df.pj@sgi.com><411685D6.5040405@watson.ibm.com><20041001164118.45b75e17.akpm@osdl.org><20041001230644.39b551af.pj@sgi.com><20041002145521.GA8868@in.ibm.com><415ED3E3.6050008@watson.ibm.com><415F37F9.6060002@bigpond.net.au><821020000.1096814205@[10.10.2.4]><20041003083936.7c844ec3.pj@sgi.com><834330000.1096847619@[10.10.2.4]><835810000.1096848156@[10.10.2.4]> <20041003175309.6b02b5c6.pj@sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Martin wrote:
>> (and existing processes forcibly migrated off)
> 
> No can do.  As described in my previous message, everything is happily
> moved already, with some user code (and a CPU_MASK_ALL patch to kthread
> I haven't submitted yet) _except_ for a few per-CPU threads such as the
> migration helpers, which can _not_ be moved off their respective CPUs.

Well, that just means we need to check for things bound to a subset when
we fork it off. ie if we have cpus 1,2,3,4 ... and there is 

A bound to 1
B bound to 2
C bound to 3
D bound to 4

Then when I fork off exclusive subset for CPUs 1&2, I have to push A & B
into it. You're right, what I said was broken ... but it doesn't seem
hard to fix.

M.

