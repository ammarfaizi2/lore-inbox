Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWEJK1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWEJK1V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWEJK1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:27:21 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64990 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964893AbWEJK1U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:27:20 -0400
Subject: Re: [PATCH -mm] megaraid gcc 4.1 warning fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, Seokmann.Ju@lsil.com, linux-kernel@vger.kernel.org
In-Reply-To: <200605100256.k4A2u3lB031731@dwalker1.mvista.com>
References: <200605100256.k4A2u3lB031731@dwalker1.mvista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Wed, 10 May 2006 11:39:18 +0100
Message-Id: <1147257558.17886.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-09 at 19:56 -0700, Daniel Walker wrote:
> Fixes the following warning,
> 
> drivers/scsi/megaraid.c: In function ‘issue_scb’:
> drivers/scsi/megaraid.c:1153: warning: passing argument 2 of ‘writel’ makes pointer from integer without a cast

And adds an exploitable memory leak. Please don't fix "bugs" blindly but
check that the error path still releases all the relevant resources.

In this case its probably sufficient just to set rval and fal through,
but each one needs to be reviewed properly.

Alan
