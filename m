Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWAFAqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWAFAqD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWAFAqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:46:01 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:33155 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932336AbWAFAqA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:46:00 -0500
Date: Thu, 5 Jan 2006 16:45:03 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Adrian Bunk <bunk@stusta.de>, "David S. Miller" <davem@davemloft.net>,
       jgarzik@pobox.com, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 1/6] drivers/net/sungem.c: gem_remove_one mustnt be __devexit
Message-ID: <20060106004503.GA25207@sorel.sous-sol.org>
References: <20060105235845.967478000@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="drivers-net-sungem.c-gem_remove_one-mustn-t-be-__devexit.patch"
In-Reply-To: <20060105235947.100933000@sorel.sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

gem_remove_one() is called from the __devinit gem_init_one().

Therefore, gem_remove_one() mustn't be __devexit.

This patch was already included in 2.6.15-rc7.


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/net/sungem.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.14.5.orig/drivers/net/sungem.c
+++ linux-2.6.14.5/drivers/net/sungem.c
@@ -2905,7 +2905,7 @@ static int __devinit gem_get_device_addr
 	return 0;
 }
 
-static void __devexit gem_remove_one(struct pci_dev *pdev)
+static void gem_remove_one(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 
@@ -3179,7 +3179,7 @@ static struct pci_driver gem_driver = {
 	.name		= GEM_MODULE_NAME,
 	.id_table	= gem_pci_tbl,
 	.probe		= gem_init_one,
-	.remove		= __devexit_p(gem_remove_one),
+	.remove		= gem_remove_one,
 #ifdef CONFIG_PM
 	.suspend	= gem_suspend,
 	.resume		= gem_resume,

--
