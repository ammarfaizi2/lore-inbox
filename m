Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWGSURl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWGSURl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 16:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWGSURl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 16:17:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:38148 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030268AbWGSURk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 16:17:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ArusfFp9c0B4y9WxkZunsUxIS0/cGVGqecudwehdqjlAqdyZqVnOtqwzBhyCFvlDzEN78l2IyDFl5ZVU6/hEseUfAgxyqybk4t6r5DVLf+dAr5A133yPvUpPGM8sJxtPT5sVtg3z/8UQigNg5PlwSZ3OFHDuRRXQ20WVbGbxZLE=
Message-ID: <d120d5000607191317k2e773af3ta5034a37db5ad97d@mail.gmail.com>
Date: Wed, 19 Jul 2006 16:17:38 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Roman Zippel" <zippel@linux-m68k.org>
Subject: Re: Fwd: Using select in boolean dependents of a tristate symbol
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0607141115010.12900@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d120d5000607131232i74dfdb9t1a132dfc5dd32bc4@mail.gmail.com>
	 <d120d5000607131235r5cc9b558xfd04a1f3118d8124@mail.gmail.com>
	 <Pine.LNX.4.64.0607140033030.12900@scrub.home>
	 <200607132231.46776.dtor@insightbb.com>
	 <Pine.LNX.4.64.0607141115010.12900@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/06, Roman Zippel <zippel@linux-m68k.org> wrote:
>
> What you could do is to use "select INPUT_FF_MEMLESS if HID" to make it
> visible that this dependency is actually for select.
> This point is a little subtle and I'm not completely happy with it, maybe
> I'm going to split this into two select variations - one which includes
> all the dependencies and one which only uses the config symbol to select.
>

Roman,

Another question for you  - what is the best way to describe
dependancy of a sub-option on a subsystem so you won't end up with the
subsystem as a module and user built in. Something like

config IBM_ASM
        tristate "Device driver for IBM RSA service processor"
        depends on X86 && PCI && EXPERIMENTAL
...
config IBM_ASM_INPUT
        bool "Support for remote keyboard/mouse"
        depends on IBM_ASM && (INPUT=y || INPUT=IMB_ASM)

But the above feels yucky. Could we have something like:

         depends on matching(INPUT, IBM_ASM)

Thank you.

-- 
Dmitry
