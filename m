Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTEMAuI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 20:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTEMAuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 20:50:08 -0400
Received: from holomorphy.com ([66.224.33.161]:31925 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263056AbTEMAuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 20:50:07 -0400
Date: Mon, 12 May 2003 18:02:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Chris Friesen'" <cfriesen@nortelnetworks.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: how to measure scheduler latency on powerpc?  realfeel doesn' t work due to /dev/rtc issues
Message-ID: <20030513010242.GO8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
	'Chris Friesen' <cfriesen@nortelnetworks.com>,
	'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>
References: <A46BBDB345A7D5118EC90002A5072C780CCB042C@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780CCB042C@orsmsx116.jf.intel.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Lee Irwin III [mailto:wli@holomorphy.com]
>> This is ridiculous. Just make sure you're not sharing interrupts and
>> count cycles starting at the ISR instead of wakeup and tag events
>> properly if you truly believe that to be your metric. You, as the
>> kernel, are notified whenever the interrupts occur and can just look
>> at the time of day and cycle counts.

On Mon, May 12, 2003 at 05:20:39PM -0700, Perez-Gonzalez, Inaky wrote:
> Well, I am only suggesting a way to _FORCE_ interrupts to happen
> at a certain rate controllable by _SOMEBODY_, not as the system
> gets them. Chris was concerned about not having a way to 
> _GENERATE_ interrupts at a certain rate.
> What you are suggesting is the other part of the picture, how to
> measure the latency and AFAICS, it is not part of the problem of
> generating the interrupts.

It also seems somewhat pointless to measure it under artificial
conditions. Interrupts happen often anyway and you probably want to
measure the effects of real drivers and kernel subsystems on the time
it takes for the blocked task to resume in userspace for real loads.
By the time you've done up custom drivers and interrupt load generators
you've completely divorced whatever you're measuring from whatever will
affect runtime in the field.

-- wli
