Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWGPE5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWGPE5i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 00:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWGPE5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 00:57:38 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:21642 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S964892AbWGPE5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 00:57:38 -0400
Date: Sun, 16 Jul 2006 00:57:34 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Catherine Zhang <cxzhang@watson.ibm.com>
cc: linux-kernel@vger.kernel.org, michal.k.k.piotrowski@gmail.com,
       catalin.marinas@gmail.com, czhang.us@gmail.com,
       Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: kernel memory leak fix for af_unix datagram getpeersec
In-Reply-To: <20060716045731.GA303@jiayuguan.watson.ibm.com>
Message-ID: <Pine.LNX.4.64.0607160052570.30274@d.namei>
References: <20060716045731.GA303@jiayuguan.watson.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jul 2006, Catherine Zhang wrote:

> 
> Hi, Catalin and Michal,
> 
> Enclosed please find the patch against 2.6.18-rc1 that fixed the kernel 
> memory leak problem.

The core kernel code doesn't know anything about secdata, as it is up to 
the LSM to determine what it is (in the case of SELinux, a kmalloc'd 
buffer).

So, you need a cleanup hook which allows the LSM to free the secdata if 
required.


- James
-- 
James Morris
<jmorris@namei.org>
