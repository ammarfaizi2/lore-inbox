Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVBRE7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVBRE7B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 23:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVBRE7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 23:59:01 -0500
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:55514 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261208AbVBRE67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 23:58:59 -0500
Subject: le conversion of posix acl fields
From: Steve French <smfrench@austin.rr.com>
To: adobriyan@mail.ru, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1108702835.6242.3.camel@smfhome.smfdom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 17 Feb 2005 23:00:50 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw your patch referenced in 
http://marc.theaimsgroup.com/?l=linux-kernel&m=110859724430665&w=2

At first glance there is one odd place in the proposed patch:

-       cifs_ace->cifs_e_perm = (__u8)cpu_to_le16(local_ace->e_perm);
-       cifs_ace->cifs_e_tag =  (__u8)cpu_to_le16(local_ace->e_tag);
+       cifs_ace->cifs_e_perm = (__u8)le16_to_cpu(local_ace->e_perm);
+       cifs_ace->cifs_e_tag = (__u8)le16_to_cpu(local_ace->e_tag);

If the field is le already then we should not convert it to cpu (since
cifs protocol assumes le format on the wire - it probably needs no
endian conversion in these two lines unless I am missing something)

