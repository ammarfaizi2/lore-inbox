Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWDIN5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWDIN5d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 09:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWDIN5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 09:57:33 -0400
Received: from mailfe12.tele2.fr ([212.247.155.108]:62604 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1750753AbWDIN5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 09:57:32 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
X-Cloudmark-Score: 0.000000 []
Date: Sun, 9 Apr 2006 15:57:20 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: torvalds@osdl.org
Cc: jordan.crouse@amd.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: "apm: set display: Interface not engaged" is back on armada laptops [Was: APM Screen Blanking fix]
Message-ID: <20060409135720.GH4708@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	torvalds@osdl.org, jordan.crouse@amd.com,
	linux-kernel@vger.kernel.org
References: <20060325134625.GA4593@bouh.residence.ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060325134625.GA4593@bouh.residence.ens-lyon.fr>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Samuel Thibault, le Sat 25 Mar 2006 14:46:25 +0100, a écrit :
> Part of a fix for APM Screen Blanking in
> arch/i386/kernel/apm.c:apm_console_blank() from Jordan Crouse was:
> 
> -       if (error == APM_NOT_ENGAGED) {
> +       if (error == APM_NOT_ENGAGED && state != APM_STATE_READY) {
> 
> for "Prevent[ing] the error message from printing out twice."
> 
> However, this puts the "apm: set display: Interface not engaged"
> error back on armada laptops (which was the original need for this if
> statement).

Here is a fix:

Fix the "apm: set display: Interface not engaged" error on Armada
laptops again.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff --git a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
index da30a37..df0e174 100644
--- a/arch/i386/kernel/apm.c
+++ b/arch/i386/kernel/apm.c
@@ -1079,7 +1079,7 @@ static int apm_console_blank(int blank)
 			break;
 	}
 
-	if (error == APM_NOT_ENGAGED && state != APM_STATE_READY) {
+	if (error == APM_NOT_ENGAGED) {
 		static int tried;
 		int eng_error;
 		if (tried++ == 0) {
