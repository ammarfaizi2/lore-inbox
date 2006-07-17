Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWGQSCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWGQSCg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 14:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWGQSCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 14:02:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:11363 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751070AbWGQSCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 14:02:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JVPJ1S+iqbDzrkTHztzpd29j7/iEWp9obx7inoTdFRyJn8Q8DGQjvzQ9kOWpgYisjouEV0mAqGRhjPIsndrt0tq658vQ4zBxtxP/TtANKUIJIq8H1eqxOPpQ6yWhnmMnb7Mniy1aZ074jkLn3zswnEjACsTO7TBp/cBVuh20tMI=
Message-ID: <d120d5000607171102g5703d546q6768ccdbd8acc97e@mail.gmail.com>
Date: Mon, 17 Jul 2006 14:02:34 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Greg KH" <gregkh@suse.de>
Subject: Re: [patch 03/45] x86_64: Fix modular pc speaker
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       "Justin Forbes" <jmforbes@linuxtx.org>,
       "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy Dunlap" <rdunlap@xenotime.net>,
       "Dave Jones" <davej@redhat.com>,
       "Chuck Wolber" <chuckw@quantumlinux.com>,
       "Chris Wedgwood" <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, "Andi Kleen" <ak@suse.de>,
       "Chris Wright" <chrisw@sous-sol.org>
In-Reply-To: <20060717162539.GD4829@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060717160652.408007000@blue.kroah.org>
	 <20060717162452.GA4829@kroah.com> <20060717162539.GD4829@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/06, Greg KH <gregkh@suse.de> wrote:
> -stable review patch.  If anyone has any objections, please let us know.
>
> ------------------
> It turned out that the following change is needed when the speaker is
> compiled as a module.
>
> Signed-off-by: Andi Kleen <ak@suse.de>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> ---
>  arch/x86_64/kernel/setup.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-2.6.17.2.orig/arch/x86_64/kernel/setup.c
> +++ linux-2.6.17.2/arch/x86_64/kernel/setup.c
> @@ -1440,7 +1440,7 @@ struct seq_operations cpuinfo_op = {
>        .show = show_cpuinfo,
>  };
>
> -#ifdef CONFIG_INPUT_PCSPKR
> +#if defined(CONFIG_INPUT_PCSPKR) || defined(CONFIG_INPUT_PCSPKR_MODULE)
>  #include <linux/platform_device.h>
>  static __init int add_pcspkr(void)
>  {

Why have this #ifdefed at all? The device is there regardless of
whether PCSPKR driver is selected and teoretically one could use an
alternative driver to speak to the hardware or decide to add pcspkr
driver later.

-- 
Dmitry
