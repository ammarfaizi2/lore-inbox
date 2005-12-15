Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbVLOUTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbVLOUTN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 15:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbVLOUTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 15:19:13 -0500
Received: from khc.piap.pl ([195.187.100.11]:15876 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751012AbVLOUTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 15:19:12 -0500
To: Dave Jones <davej@codemonkey.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: agpgart.ko can't be unloaded
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 15 Dec 2005 21:19:10 +0100
Message-ID: <m3acf2i05d.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently noticed that agpgart.ko (and corresponding hardware driver)
can't be unloaded:

Module                  Size  Used by
intel_agp              19228  1 
agpgart                27592  1 intel_agp

The same is true for via_agp and probably for all other drivers.

The problem is agpgart increases reference count of hw driver
to prevent it from being unloaded, and the hw driver references
agpgart so agpgart can't be unloaded either.

Should agpgart be split into 2 parts, one (which would have to be unloaded
first) managing the thing and the other - the library referenced by
hw drivers?

I wouldn't write about this but there is code to unload them so I think
it's not intentional.
-- 
Krzysztof Halasa
