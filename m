Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVCTNpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVCTNpk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 08:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVCTNpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 08:45:40 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:11218 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261214AbVCTNpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 08:45:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=gNB/zL6uIGOCNc9Yqe5uWK7cHtUY5e7sXJ+OFVXZ9Z/BIXHLBjjkF8Z2fIMW3MHxHXeD05QKxqk5hih1grYpjONTuM8TrCWp/Q6fhs+PUdSyRf+/0+U1A1vv7nOtRxiz0z3zrPiSdY+OG+irR7uz9z/twd6JgfB4LAylJTfZYm4=
Message-ID: <aec7e5c305032005451899b18b@mail.gmail.com>
Date: Sun, 20 Mar 2005 14:45:36 +0100
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: af_unix.c, KBUILD_MODNAME and unix
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

af_unix.c is currenty built with KBUILD_MODNAME=unix. This seems to
work rather well today, but if someone actually tries to use
KBUILD_MODNAME then they will end up with a preprocessor surprise:
KBUILD_MODNAME -> unix -> 1, because "unix" is defined to 1.

With other words, if someone adds module_param(foo,...) code to
af_unix.c and compiles the code as built in then they will have to use
"1.foo" to set the variable instead of "unix.foo" as expected.

Solution? #undef unix?

I came across this when trying to autogenerate parameter documentation...

/ magnus
