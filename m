Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVLKRS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVLKRS1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 12:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVLKRS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 12:18:27 -0500
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:26214 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1750724AbVLKRS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 12:18:26 -0500
Subject: discontiguous mapping with remap_pfn_range
From: Imre Deak <imre.deak@nokia.com>
Reply-To: imre.deak@nokia.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Nokia
Date: Sun, 11 Dec 2005 19:18:22 +0200
Message-Id: <1134321502.12362.48.camel@bitbox.mine.nu>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after the recent changes in remap_pfn_range it's not possible any more
to create a mapping for a physically discontiguous range for which no
struct page exists.

Earlier it was achieved by calling remap_pfn_range for each physical
region with the same vma, but now this will result in
incomplete_pfn_remap which handles only normal mappings, that is where
we have struct page for each PFN.

I would need such a mapping for a frame buffer consisting of two
discontiguous physical range. Is there any way I can do this with the
current API? If not, is there a plan to support it (with a vm_insert_pfn
for example) ? I know it's a rare HW configuration, but there might be
some other use case for this.

Thanks,
Imre


