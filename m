Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbUJ0EsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbUJ0EsS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 00:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbUJ0EsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 00:48:18 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:10724 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261627AbUJ0EsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 00:48:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=D89yWNpyouXmuR5+ONgMEO38j7TVqQeKu04qxhezbbr/WdXSivwFgsguavcju6f6e/vLO914Uj6C/V5VWNURkttTvGwBQtDd/L0gPJTuO01Vew0DV3X7T7qN2VsdYRedmiu+e3T1rf0rhco41hCSnpqUIFpxWurlqkrE57qgjhU=
Message-ID: <b2fa632f0410262148411ad85a@mail.gmail.com>
Date: Wed, 27 Oct 2004 10:18:10 +0530
From: Raj <inguva@gmail.com>
Reply-To: Raj <inguva@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Problems with close() system call
Cc: Arne Henrichsen <ahenric@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0410261739470.641@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <605a56ed04102504401e0f469f@mail.gmail.com>
	 <Pine.LNX.4.53.0410261329410.26803@yvahk01.tjqt.qr>
	 <605a56ed04102605433b9f368@mail.gmail.com>
	 <Pine.LNX.4.53.0410261739470.641@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004 17:43:36 +0200 (MEST), Jan Engelhardt
<jengelh@linux01.gwdg.de> wrote:
> >> Best is to put a printk("i'm in ioctl()") in the ioctl() function and a
> >> printk("i'm in close()") in the close() one, to be really sure whether the
> >> close() function of your module is called.
> >
> >Yes, that is exactly what I am doing. I basically implement the
> >flush() call (for close) as the release() call was never called on
> >close. So my release call does nothing. What I see is that the flush
> 
> Uh, then something's wrong. Your device fops should look like this:
> {
>   .release = my_close, // which is called upon close(2)
> }
> 
> Anything else is of course, never working.

iirc, once i faced this problem. I compiled a sample device driver
against kernel version
'X'. and tried to insmod the binary into kernel version 'Y' which had
it's fop's struct
modified. The structure offsets took a beating and all hell broke
loose. Calling open()
called something else etc.... Ever since, i started using the above notation to
initialize struct members. Hard learned lesson ;-)

-- 
######
raj
######
