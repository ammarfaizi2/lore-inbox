Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVA1Boc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVA1Boc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 20:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVA1Boc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 20:44:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55183 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261375AbVA1BoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 20:44:25 -0500
Date: Thu, 27 Jan 2005 20:43:18 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jasper Spaans <jasper@vs19.net>, Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, <ajgrothe@yahoo.com>, <bunk@stusta.de>
Subject: Re: crypto algoritms failing?
In-Reply-To: <20050128004755.GA6676@spaans.vs19.net>
Message-ID: <Xine.LNX.4.44.0501272023080.7174-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005, Jasper Spaans wrote:

> On Thu, Jan 27, 2005 at 07:38:43PM -0500, James Morris wrote:
> > > Is this supposed to happen?
> > 
> > No.  What is your kernel version?
> 
> Current bitkeeper + latest swsusp2 patches and hostap driver, however, those
> two don't come near touching the crypto stuff[1] so they're not really on my
> suspect shortlist, but I'll see if I can find time to build a vanilla one
> tomorrow (that is, without swsusp/hostap).. right now, it's time to sleep in
> my local timezone..

Looks like a cleanup broke the test vectors:
http://linux.bkbits.net:8080/linux-2.5/gnupatch@41ad5cd9EXGuUhmmotTFBIZdIkTm0A

Patch below, please apply.

Signed-off-by: James Morris <jmorris@redhat.com>


---

diff -purN -X dontdiff linux-2.6.11-rc1-mm1.o/crypto/tcrypt.h linux-2.6.11-rc1-mm1.w/crypto/tcrypt.h
--- linux-2.6.11-rc1-mm1.o/crypto/tcrypt.h	2005-01-19 09:30:32.000000000 -0500
+++ linux-2.6.11-rc1-mm1.w/crypto/tcrypt.h	2005-01-27 20:28:23.312918312 -0500
@@ -1986,7 +1986,7 @@ static struct cipher_testvec arc4_dec_tv
 #define TEA_ENC_TEST_VECTORS	4
 #define TEA_DEC_TEST_VECTORS	4
 
-static struct cipher_testvec xtea_enc_tv_template[] =
+static struct cipher_testvec tea_enc_tv_template[] =
 {
 	{
 		.key    = { [0 ... 15] = 0x00 },
@@ -2080,7 +2080,7 @@ static struct cipher_testvec tea_dec_tv_
 #define XTEA_ENC_TEST_VECTORS	4
 #define XTEA_DEC_TEST_VECTORS	4
 
-static struct cipher_testvec tea_enc_tv_template[] =
+static struct cipher_testvec xtea_enc_tv_template[] =
 {
 	{
 		.key    = { [0 ... 15] = 0x00 },




