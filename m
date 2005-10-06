Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbVJFV3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVJFV3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 17:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbVJFV3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 17:29:21 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:11388 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751212AbVJFV3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 17:29:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=e4nVUqrOYQe9qXiwTUB7G8WLOMpoEN+OyR6zskRvVFLzkI3mCn5odH6QIFyidz9MX6TG/XgihBeSQAmoYzs9PY2yruOSwm5pPYWouSX9dX2zJEztmGmtd1TcN3MZ3/i1OpHudmRIPhn1dUQhaoTCzYi++cbSkua/pSUm/tRG744=
Date: Fri, 7 Oct 2005 01:40:43 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] ipw2200: check version in eeprom correctly
Message-ID: <20051006214043.GA2370@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 I'm not 100% sure the fix is right, but the condition looks bogus:
	->eeprom is "u8 eeprom[256]".

 drivers/net/wireless/ipw2200.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- ./drivers/net/wireless/ipw2200.c
+++ ./drivers/net/wireless/ipw2200.c
@@ -1699,7 +1699,7 @@ static void ipw_eeprom_init_sram(struct 
 	   copy.  Otherwise let the firmware know to perform the operation
 	   on it's own
 	 */
-	if ((priv->eeprom + EEPROM_VERSION) != 0) {
+	if ((priv->eeprom[EEPROM_VERSION]) != 0) {
 		IPW_DEBUG_INFO("Writing EEPROM data into SRAM\n");
 
 		/* write the eeprom data to sram */

