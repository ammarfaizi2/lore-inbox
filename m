Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933907AbWKTJfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933907AbWKTJfc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 04:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934031AbWKTJfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 04:35:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:6521 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S933907AbWKTJfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 04:35:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cBD1pgboWRCcPvNUwXJ4OHEpeE/7WJPfUVbnSMBZQVcj2BtUMlj4UKgv9dIq52lJRracR2dUKx2q97AixbyqiZEB+caiSdCMCohxH/r+0ddWt2OIQ03Z/Ujuga+2GdYOsxX30w5l07ntcK699+T5A5EZJjZJof6455Z9d7bS7gg=
Message-ID: <74d0deb30611200135m2851a47fjc8253a52dca0c1d0@mail.gmail.com>
Date: Mon, 20 Nov 2006 10:35:30 +0100
From: "pHilipp Zabel" <philipp.zabel@gmail.com>
To: "Paul Sokolovsky" <pmiscml@gmail.com>
Subject: Re: Where did find_bus() go in 2.6.18?
Cc: linux-kernel@vger.kernel.org, "Adrian Bunk" <bunk@stusta.de>,
       "Greg Kroah-Hartman" <gregkh@suse.de>, kernel-discuss@handhelds.org
In-Reply-To: <1154868495.20061120003437@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1154868495.20061120003437@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 11/19/06, Paul Sokolovsky <pmiscml@gmail.com> wrote:
> Hello linux-kernel,
>
>   We here at Handhelds.org upgrading our drivers to 2.6.18 and I just
> caught a case of find_bus() being undefined during link.

I assume you are referring to the ipaq h2200 battery driver that uses
    bus = find_bus("w1");
to "find" the one wire bus?

I think the solution would be to use w1_bus_type instead, but for that
it would have to be exported.

Index: linux-2.6/drivers/w1/w1.c
===================================================================
--- linux-2.6.orig/drivers/w1/w1.c      2006-10-28 22:58:11.000000000 +0200
+++ linux-2.6/drivers/w1/w1.c   2006-10-29 02:01:30.000000000 +0200
@@ -194,7 +194,7 @@

 static int w1_uevent(struct device *dev, char **envp, int num_envp, char *buffe
r, int buffer_size);

-static struct bus_type w1_bus_type = {
+struct bus_type w1_bus_type = {
        .name = "w1",
        .match = w1_master_match,
        .uevent = w1_uevent,
@@ -978,3 +978,5 @@

 module_init(w1_init);
 module_exit(w1_fini);
+
+EXPORT_SYMBOL_GPL(w1_bus_type);

regards
Philipp
