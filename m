Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031156AbWKUQhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031156AbWKUQhO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 11:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031135AbWKUQhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 11:37:14 -0500
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:24805 "EHLO
	mtiwmhc11.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1031066AbWKUQhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 11:37:12 -0500
Message-ID: <45632B30.9090506@lwfinger.net>
Date: Tue, 21 Nov 2006 10:37:04 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Ray Lee <ray-lk@madrabbit.org>, linux-kernel@vger.kernel.org
Subject: Re: Problem with DMA on x86_64 with 3 GB RAM
References: <455B63EC.8070704@madrabbit.org> <20061118112438.GB15349@nineveh.rivenstone.net> <1163868955.27188.2.camel@johannes.berg> <455F3D44.4010502@lwfinger.net> <455F4271.1060405@madrabbit.org> <455FF672.4070502@lwfinger.net> <p73psbhay8n.fsf@bingen.suse.de>
In-Reply-To: <p73psbhay8n.fsf@bingen.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Larry Finger <Larry.Finger@lwfinger.net> writes:
> 
>> I am trying to debug a bcm43xx DMA problem on an x86_64 system with 3
>> GB RAM. Depending on the particular chip and its implementation, dma
>> transfers may use 64-, 32-, or 30-bit addressing, with the problem
>> interface using 30-bit addressing. From test prints, the correct mask
>> (0x3FFFFFFF) is supplied to pci_set_dma_mask and
>> pci_set_consistent_dma_mask. Neither call returns an error. In
>> addition, several x86_64 systems with more than 1 GB RAM have worked
>> with the current code.
> 
> 30bit DMA has be bounced through GFP_DMA. The driver needs special
> code for this. You can look at the b44 driver for a working reference.
> 
> The pci_dma_* interfaces on x86-64 only support masks >= 0xffffffff,
> anything smaller has to be handled manually.

Thanks for the info. I obviously get to devote some effort to seeing how the b44 code handles the 
same problem.

Shouldn't this problem be mentioned somewhere in the documentation, or did I miss something?

Larry
