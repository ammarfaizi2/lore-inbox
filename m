Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbVJKHWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbVJKHWp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 03:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbVJKHWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 03:22:45 -0400
Received: from spc1-leed3-6-0-cust185.seac.broadband.ntl.com ([80.7.68.185]:33427
	"EHLO fentible.pjc.net") by vger.kernel.org with ESMTP
	id S1751404AbVJKHWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 03:22:44 -0400
Message-ID: <434B6839.30600@tykepenguin.com>
Date: Tue, 11 Oct 2005 08:22:33 +0100
From: Patrick Caulfield <patrick@tykepenguin.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davem@davemloft.net
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] DECnet tidy
X-Enigmail-Version: 0.92.0.0
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAHlBMVEXmxsMFAgCWmaJAJSmo
 bWgJBADGoakXEBRfXFQIBAjp3NUzAAACaElEQVQ4jVXTQWvbMBQHcNFBtqsoIeRWRsm22zYV5F2z
 h9HVFJH5VooRO654QfWtxV6n3ma64Pnb7v8kJ01fSGL003t6z9jCFvwp7KD01lpbevxKhMCynRd2
 U/P6XNrBHwG+tW8aXrDWbwv8z4WNMSjvSyxg18bLlBGjBmzj1c56bJhPsFFK+x3XLEfr+5ixSwlK
 ee7JWsBNBI+Sc8UA2URoImhdyAWDbgaGsvR8SCGU6uXApVTjUxImQtcitL30PtXyvvYDdqG/AiAX
 WJgg03zNjQsyctEMMQVx8dXrCd6+lwPXyDKsBzLMEdz3BCpw5FVqvJCAJRf3KgvBkKsCYKNupBBv
 eu8HX+eOOnKuot/eb3SEseZ2sOYQBCgv6RfgFaBWnUsBaOzl+QG4SgyUKu236nGCjEJH+ZWYVcgY
 7N/ZBDozwYQud86EVmv7Z3YPeM0QciLKXWU6auvtDzGByrrKBABRIFLNHp7aDPsNUUXrNpDyHycY
 sNvxdoyI0P5sDxRyADrqmNtbIT4B3o2DQ3keASdgxPbzHsYEtIezA6DXCI6haq8SfBjHhz2YmPEM
 P19AEEKMCf6dEx+dA+gY+tMKsyHi+PQA6BMsuzwCR053Qsw443Ec5VOcO3acE84+SdDL0zg30tAv
 odKJjCDlYo3dbuau+Z6IQ4aUy26F6YWokLU+BnnBtbgDV929gFtaudQTnR1gCVh069hxFcc7ypCB
 0oymjRn9M3RpjqDVag9cahn4jqOBFk97tjpkLOvOoOP82mRtfIF0L8T9iHXV8bNIBq9I22ahVVqI
 L318sPhkfkMMUgJekv/6D1oqiFUyQgAAAABJRU5ErkJggg==
Content-Type: multipart/mixed;
 boundary="------------010301080408060503050908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010301080408060503050908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This just removes some redundant ifdeffed code:


-- 

patrick

--------------010301080408060503050908
Content-Type: message/rfc822;
 name="Another small patch.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Another small patch.eml"



Signed-off-by: Steven Whitehouse <steve@chygwyn.com>
Signed-off-by: Patrick Caulfield <patrick@tykepenguin.com>

diff -Nru linux-2.6.13/net/decnet/af_decnet.c linux/net/decnet/af_decnet.c
--- linux-2.6.13/net/decnet/af_decnet.c	2005-10-03 21:16:48.000000000 +0100
+++ linux/net/decnet/af_decnet.c	2005-10-07 11:21:25.000000000 +0100
@@ -719,22 +719,9 @@
 	if (saddr->sdn_flags & ~SDF_WILD)
 		return -EINVAL;
 
-#if 1
 	if (!capable(CAP_NET_BIND_SERVICE) && (saddr->sdn_objnum ||
 	    (saddr->sdn_flags & SDF_WILD)))
 		return -EACCES;
-#else
-	/*
-	 * Maybe put the default actions in the default security ops for
-	 * dn_prot_sock ? Would be nice if the capable call would go there
-	 * too.
-	 */
-	if (security_dn_prot_sock(saddr) &&
-	    !capable(CAP_NET_BIND_SERVICE) || 
-	    saddr->sdn_objnum || (saddr->sdn_flags & SDF_WILD))
-		return -EACCES;
-#endif
-
 
 	if (!(saddr->sdn_flags & SDF_WILD)) {
 		if (dn_ntohs(saddr->sdn_nodeaddrl)) {




--------------010301080408060503050908--
