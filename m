Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWDUWx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWDUWx2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 18:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWDUWx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 18:53:28 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:23099 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750702AbWDUWx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 18:53:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=dD4J+xx309aPSrTp4veyIxCDrHeOEhtxBnagX96sxmWMV5zsc2kBbvHU8spjQQIM67Bzaha6M3Q4NnyUkSddEtw68RK4V5VxUeHDbCC+NlNFQdIXSRVeJiaQIuerySjYFvPG+EfwSUCRAYYr3eUKsg7ZrW+LZXXiRANjlY969Dk=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <jmorris@namei.org>, <dwalker@mvista.com>, <linux-kernel@vger.kernel.org>
Subject: RE: kfree(NULL)
Date: Fri, 21 Apr 2006 15:53:24 -0700
Message-ID: <000e01c66596$66961750$853d010a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20060421144233.1201cf07.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcZljCglMujWq5zUQmWHN3+qca9LZwACb4cg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> struct likeliness {
> 	char *file;
> 	int line;
> 	atomic_t true_count;
> 	atomic_t false_count;
> 	struct likeliness *next;
> };

It seems including atomic.h inside compiler.h is a bit tricky (might have interdependency).

Can we just live with int instead of atomic_t? We don't really care about losing a count occasionally..

> It'll crash if a module gets registered then unloaded. 
> CONFIG_MODULE_UNLOAD=n would be required.

What about init data that is thrown away after boot?

Hua

