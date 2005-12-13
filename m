Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbVLMScF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbVLMScF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 13:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbVLMScE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 13:32:04 -0500
Received: from 213-140-2-69.ip.fastwebnet.it ([213.140.2.69]:42895 "EHLO
	aa002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932582AbVLMScD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 13:32:03 -0500
Date: Tue, 13 Dec 2005 19:32:48 +0100
From: Mattia Dongili <malattia@linux.it>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Stelian Pop <stelian@popies.net>
Subject: Re: [RFT] Sonypi: convert to the new platform device interface
Message-ID: <20051213183248.GA3606@inferi.kami.home>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	LKML <linux-kernel@vger.kernel.org>,
	Stelian Pop <stelian@popies.net>
References: <200512130219.41034.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512130219.41034.dtor_core@ameritech.net>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.15-rc5-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 02:19:40AM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> Now that we allow manual binding and unbinding devices through sysfs it
> is better if main device initialization is done in ->probe() instead of
> module_init(). The following patch converts sonypi driver to this model.
> 
> The patch compiles but I was unable to test it since I don't have the
> hardware...
[...]
> +static int __devinit sonypi_setup_irq(struct sonypi_device *dev,
> +				      const struct sonypi_irq_list *irq_list)
> +{
> +	while (irq_list->irq) {
> +
> +		if (!request_irq(dev->irq, sonypi_irq,
                                 ^^^^^^^^
this should be irq_list->irq

other than that seems to work here on a type2 model:

sonypi: Sony Programmable I/O Controller Driver v1.26.
sonypi: trying irq 11
input: Sony Vaio Jogdial as /class/input/input8
input: Sony Vaio Keys as /class/input/input9
sonypi: detected type2 model, verbose = 1, fnkeyinit = off, camera = off, compat = off, mask = 0xffffffff, useinput = on, acpi = on
sonypi: enabled at irq=11, port1=0x1080, port2=0x1084
sonypi: device allocated minor is 63
sonypi: unknown event port1=0x0f,port2=0x05

Oh, there seems to be a spurious interrupt happening at modules
insertion (I suspect sonypi_enable triggering and ignoring it), but this
happens with the old module too and I never noticed it before. Wouldn't
make more sense to print the warning even if verbose=0 to be able to
catch it timely? I mean it's since 2.4 times I don't enable verbose mode
in sonypi...

-- 
mattia
:wq!
