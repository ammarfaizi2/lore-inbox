Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUJVRZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUJVRZy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 13:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUJVRMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:12:49 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:29208 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265805AbUJVRIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:08:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=lsImcVc2ttOeGG/QHR2WKBWjzpRIZg1rBmvv8dTX2DdSjmzrlwqD1MVmd/Pjc6Poys7bvz400/nzIEW/C0Lcx/p4xro8D9Jrp/UTLTlxVhxwk9oqOavAWLq2LKsIpBW7Y790IdWzp/FNY5xr468QaggW5LvHG9l1250QH1bPA9g=
Message-ID: <9e473391041022100835da7baf@mail.gmail.com>
Date: Fri, 22 Oct 2004 13:08:08 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: getting rid of inter_module_xx
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking at getting rid of DRM's use of inter_module_xx. DRM makes
use of this to locate and use the AGP module. AGP is an optional
module since some system only have PCI graphics.

Right now DRM uses inter_module_get("AGP") to locate the module if it
exists. It then changes behavior if this call secedes or fails.

If I remove inter_module_get("AGP") and use the symbols directly, such
as agp_backend_acquire(), how do I resolve the symbol link when AGP is
not loaded? If the symbols link as NULL DRM will see that and act
correctly.

-- 
Jon Smirl
jonsmirl@gmail.com
