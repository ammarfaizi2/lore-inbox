Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVBJBms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVBJBms (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 20:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVBJBms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 20:42:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44762 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262007AbVBJBmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 20:42:46 -0500
Date: Wed, 9 Feb 2005 20:42:37 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Fruhwirth Clemens <clemens@endorphin.org>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <michal@logix.cz>, "David S. Miller" <davem@davemloft.net>,
       "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: [PATCH 01/04] Adding cipher mode context information to crypto_tfm
In-Reply-To: <1107997358.7645.24.camel@ghanima>
Message-ID: <Xine.LNX.4.44.0502092036200.6541-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2005, Fruhwirth Clemens wrote:

> Because a tweak is different from an IV. There can be an arbitrary
> number of tweaks. For instance, EME takes 1 tweak per 512 bytes. If you
> have a 4k page to encrypt, you have to process 8 tweaks of whatever
> size. 
>  Therefore, you need 3 scatterlists: src, dst and the running along
> tweak.

The purpose of the scatterlists is to be able to process discontigous data 
at the page level.

The tweak, as I understand it, is something which you generate, and it is 
not inherently likely to be page-level clumps of data.  It does not ever 
need to be kmapped.

What you really need to do is use an array for the tweak (or possibly a
structure which maintains state about it if needed).


- James
-- 
James Morris
<jmorris@redhat.com>


