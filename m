Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131197AbRCRJna>; Sun, 18 Mar 2001 04:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131236AbRCRJnU>; Sun, 18 Mar 2001 04:43:20 -0500
Received: from web1105.mail.yahoo.com ([128.11.23.125]:17928 "HELO
	web1105.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S131197AbRCRJnO>; Sun, 18 Mar 2001 04:43:14 -0500
Message-ID: <20010318094232.12088.qmail@web1105.mail.yahoo.com>
Date: Sun, 18 Mar 2001 10:42:32 +0100 (CET)
From: willy tarreau <wtarreau@yahoo.fr>
Subject: [PATCH] printk msglevel identification broken since 2.4.2ac13
To: andrewm@uow.edu.au, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-650250286-984908552=:10413"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-650250286-984908552=:10413
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Hi Andrew & Alan,

I noticed that in 2.4.2ac20, all netfilter logs come
to
the console, whatever the log levels, and the
beginning
of the line is always prepended with '<4>'.

I found in printk.c that a test is done for the length
of the message to be strictly larger than 3 chars. But
ipt_LOG uses 2 consecutive printk, one with only '<4>'
and one with the message. It may be possible that
other
drivers to the same. Looking back in patches show this
is present since 2.4.2ac13.

This trivial patch allows a 3-char message to set the
message level.

Cheers,
Willy


___________________________________________________________
Do You Yahoo!? -- Pour dialoguer en direct avec vos amis, 
Yahoo! Messenger : http://fr.messenger.yahoo.com
--0-650250286-984908552=:10413
Content-Type: application/x-unknown; name="2.4.2-ac20-printk-fix"
Content-Transfer-Encoding: base64
Content-Description: 2.4.2-ac20-printk-fix
Content-Disposition: attachment; filename="2.4.2-ac20-printk-fix"

ZGlmZiAtdXJOIDIuNC4yLWFjMjAva2VybmVsL3ByaW50ay5jIDIuNC4yLWFj
MjAtcHJpbnRrZml4L2tlcm5lbC9wcmludGsuYwotLS0gMi40LjItYWMyMC9r
ZXJuZWwvcHJpbnRrLmMJV2VkIE1hciAxNCAwNzo0MDowNiAyMDAxCisrKyAy
LjQuMi1hYzIwLXByaW50a2ZpeC9rZXJuZWwvcHJpbnRrLmMJU3VuIE1hciAx
OCAxMDoxMDozMSAyMDAxCkBAIC0zMjgsNyArMzI4LDcgQEAKIAlzdGFydF9w
cmludCA9IHN0YXJ0OwogCXdoaWxlIChjdXJfaW5kZXggIT0gZW5kKSB7CiAJ
CWlmICgJbXNnX2xldmVsIDwgMCAmJgotCQkJKChlbmQgLSBjdXJfaW5kZXgp
ID4gMykgJiYKKwkJCSgoZW5kIC0gY3VyX2luZGV4KSA+PSAzKSAmJgogCQkJ
TE9HX0JVRihjdXJfaW5kZXggKyAwKSA9PSAnPCcgJiYKIAkJCUxPR19CVUYo
Y3VyX2luZGV4ICsgMSkgPj0gJzAnICYmCiAJCQlMT0dfQlVGKGN1cl9pbmRl
eCArIDEpIDw9ICc3JyAmJgo=

--0-650250286-984908552=:10413--
