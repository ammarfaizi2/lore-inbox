Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVANWFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVANWFS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 17:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVANWFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 17:05:18 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:47802 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262170AbVANWDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 17:03:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=oqSuHr/l6yyIFlxQduHV9Zjp8j23xOSqcJgNmfix+t+0xyY1gh39w8jYOR/dHoGWw3eADwcklMtM037A7b6SfXGh8IlaT+BYJfABNMscBlj4d351bmnoG17Sjb0VVUX64/4TAbou9e36AKXdEBPO+dIdaqzYnNEIgdjr4COXG40=
Message-ID: <a36005b50501141403395e8558@mail.gmail.com>
Date: Fri, 14 Jan 2005 14:03:04 -0800
From: Ulrich Drepper <drepper@gmail.com>
Reply-To: Ulrich Drepper <drepper@gmail.com>
To: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] fix xenU kernel crash in dmi_iterate
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ian Pratt <m+Ian.Pratt@cl.cam.ac.uk>
In-Reply-To: <Pine.LNX.4.61.0501141446010.2701@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.61.0501141446010.2701@chimarrao.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2005 14:49:10 -0500 (EST), Rik van Riel <riel@redhat.com> wrote:
>         char __iomem *p, *q;
> 
>         for (p = q = ioremap(0xF0000, 0x10000); q < p + 0x10000; q += 16) {
> +               if (p == NULL)
> +                       return -1;
>                 memcpy_fromio(buf, q, 15);
>                 if(memcmp(buf, "_DMI_", 5)==0 && dmi_checksum(buf))
>                 {

SInce p is not modified in the loop, this certainly should look like this

p = ioremap(0xF0000, 0x10000);
if (p == NULL)
  return -1;
for (q = p; q < p + 0x10000; q += 16) {
  memcpy_fromio(buf, q, 15);
  ...
