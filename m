Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422642AbWF0WLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422642AbWF0WLT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbWF0WLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:11:19 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:51864 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030431AbWF0WLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:11:19 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44A1AC3D.6080801@s5r6.in-berlin.de>
Date: Wed, 28 Jun 2006 00:07:57 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
CC: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Robert Hancock <hancockr@shaw.ca>, Ben Collins <bcollins@ubuntu.com>,
       Jody McIntyre <scjody@modernduck.com>
Subject: Re: [PATCH 18/25] ohci1394: Fix broken suspend/resume in ohci1394
References: <20060627200745.771284000@sous-sol.org> <20060627201539.350588000@sous-sol.org>
In-Reply-To: <20060627201539.350588000@sous-sol.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.9) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
...
> From: Robert Hancock <hancockr@shaw.ca>
...
> I created the patch below and tested it, and it appears to resolve the
> suspend problems I was having with the module loaded. I only added in
> the pci_save_state and pci_restore_state - however, though I know little
> of this hardware, surely the driver should really be doing more than
> this when suspending and resuming? Currently it does almost nothing,
> what if there are commands in progress, etc?
...

This patch is OK. (Although unlike one might expect from reading the 
patch title, there is still a lot to do for full suspend/resume 
functionality in ohci1394.) Just FYI, here is my reply to Robert's 
initial patch submission:

| Thanks, this is at least a start. Apart from the code for PPC Macintoshs,
| ohci1394 does indeed lack any suspend/resume handling. I don't know
| anything about this matter, however the OHCI spec (gratis available,
| linked from www.linux1394.org) table A-11 on page 168 says which losses
| of configuration result from what power state transitions: Interrupts are
| masked when going into D1. IEEE 1394 configuration is lost when going
| into D2. PCI configuration is lost when going into D3. Since we don't
| handle this yet, a suspend/resume cycle results at least in loss of
| FireWire connectivity.
|
| As you may have guessed, this problem is basically as old as the driver.
| Nobody is actively working on it AFAIK. ["it" = the resume problem]
| (Except that I dusted off an old notebook and put a fresh Linux distro on
| it --- with the plan [to] check power management and hot ejection
| handling by ohci1394... later this year...)
-- 
Stefan Richter
-=====-=-==- -==- ==-==
http://arcgraph.de/sr/
