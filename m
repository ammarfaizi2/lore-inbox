Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWIGTE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWIGTE0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 15:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWIGTEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 15:04:25 -0400
Received: from hera.kernel.org ([140.211.167.34]:53969 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751277AbWIGTEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 15:04:23 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Andreas Steinmetz <ast@domdv.de>
Subject: Re: [2.6.17.8] noapic and /proc/acpi/event
Date: Thu, 7 Sep 2006 15:05:49 -0400
User-Agent: KMail/1.8.2
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
References: <45006A6F.8030801@domdv.de>
In-Reply-To: <45006A6F.8030801@domdv.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609071505.49820.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 September 2006 14:52, Andreas Steinmetz wrote:
> I do have a problem with a new laptop (Acer Ferrari 4006):
> 
> It does suspend either to disk or to ram only when I do boot with
> "noapic". So far, so good.

Well no, that isn't so good either.  You shouldn't need "noapic"
for anything, either normal operation or suspend/resume.

Do ACPI events work properly w/o noapic if you don't suspend/resume?

You should be able to kill acpid, and cat /proc/acpi/event
and open/close your lid and watch events appear --
same for power button.
You should also be able to see the acpi line in /proc/interrupts
increment for each of these events.

> If, however, I do boot with "noapic" no events are delivered to
> /proc/acpi/event so lid switch and power button can't be used to suspend
> anymore.

Does noapic work properly before the suspend?
(test the same way as w/o noapic above)

> The strange thing is, that at least in /proc/acpi/button/lid/LID/state I
> can view the lid switch state.

The problem with your system is that it isn't getting ACPI interrupts.
The lid state in /proc is immune to that problem because when
you read that file Linux asks the hardware for its state on demand.

cheers,
-Len
 
