Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWEVVSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWEVVSx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 17:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWEVVSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 17:18:53 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:23284 "EHLO
	ms-smtp-05.texas.rr.com") by vger.kernel.org with ESMTP
	id S1751198AbWEVVSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 17:18:52 -0400
Message-ID: <44722ACE.3040500@austin.rr.com>
Date: Mon, 22 May 2006 16:19:10 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: charset2upper broken
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charset2upper is broken, at least for utf8 (see line 41 of nls_utf8.c)   
Seems straightforward to fix it for the key characters a-z (0x61-0x7a), 
unless the uppercasing rules are stranger than I think - especially 
since other places have it right e.g. nls_base.c seems to have it right 
in its charset2upper.

I need to uppercase passwords for cifs to be able to mount to older 
servers (e.g. win9x and OS/2) but since I can't tell that 
utf8->charset2upper is broken I can't know when to fall back to the 
simpleminded way of uppercasing that smbfs does.

I wish we could make theis charset2upper (and charset2lower probably) 
optional so it could be set to null when broken or at least return an 
error for those cp that are broken such as utf8 so we could fall back 
... (and unfortunately utf8 is the default ...)

Apparently this breaks other guys too  see below ...

On Sat, Oct 29, 2005 at 12:07:40AM +0900, OGAWA Hirofumi wrote:
 >/ OGAWA Hirofumi <hirofumi@xxxxxxxxxxxxxxxxxx> writes:/
 >/ /
 >/ > Horms <horms@xxxxxxxxxxxx> writes:/
 >/ >/
 >/ >> static struct nls_table table = {/
 >/ >> .charset = "utf8",/
 >/ >> .uni2char = uni2char,/
 >/ >> .char2uni = char2uni,/
 >/ >> .charset2lower = identity, /* no conversion *//
 >/ >> .charset2upper = identity,/
 >/ >> .owner = THIS_MODULE,/
 >/ >> };/
 >/ >>/
 >/ >> I guess it is charset2lower or charset2upper that vfat is calling,/
 >/ >> which make no conversion, thus leading to the problem I outlined 
above./
 >/ >>/
 >/ >> My question is: Is this behaviour correct, or is it a bug?/
 >/ >/
 >/ > This is known bug. For fixing this bug cleanly, we will need to much/
 >/ > change the both of nls and filesystems./
 >/ /
 >/ And fatfs has "utf8" option, probably the behavior is preferable than/
 >/ "iocharset=utf8". However, unfortunately "utf8" has problem too./


