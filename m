Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbVIHOdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbVIHOdj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 10:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVIHOdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 10:33:39 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:62043
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932517AbVIHOdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 10:33:38 -0400
Message-Id: <43206825020000780002441A@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 16:34:45 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] minor fbcon_scroll adjustment
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part52703C15.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part52703C15.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

An adjustment to the SM_DOWN case of fbcon_scroll to match the behavior
of
SM_UP.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/drivers/video/console/fbcon.c
2.6.13-fbcon-logo-scroll-down/drivers/video/console/fbcon.c
--- 2.6.13/drivers/video/console/fbcon.c	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-fbcon-logo-scroll-down/drivers/video/console/fbcon.c	2005-09-07
11:15:44.000000000 +0200
@@ -1662,6 +1662,8 @@ static int fbcon_scroll(struct vc_data *
 	case SM_DOWN:
 		if (count > vc->vc_rows)	/* Maximum realistic
size */
 			count = vc->vc_rows;
+		if (logo_shown >= 0)
+			goto redraw_down;
 		switch (p->scrollmode) {
 		case SCROLL_MOVE:
 			ops->bmove(vc, info, t, 0, t + count, 0,


--=__Part52703C15.0__=
Content-Type: application/octet-stream; name="linux-2.6.13-fbcon-logo-scroll-down.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-fbcon-logo-scroll-down.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCkFuIGFkanVzdG1lbnQgdG8gdGhlIFNNX0RP
V04gY2FzZSBvZiBmYmNvbl9zY3JvbGwgdG8gbWF0Y2ggdGhlIGJlaGF2aW9yIG9mClNNX1VQLgoK
U2lnbmVkLW9mZi1ieTogSmFuIEJldWxpY2ggPGpiZXVsaWNoQG5vdmVsbC5jb20+CgpkaWZmIC1O
cHJ1IDIuNi4xMy9kcml2ZXJzL3ZpZGVvL2NvbnNvbGUvZmJjb24uYyAyLjYuMTMtZmJjb24tbG9n
by1zY3JvbGwtZG93bi9kcml2ZXJzL3ZpZGVvL2NvbnNvbGUvZmJjb24uYwotLS0gMi42LjEzL2Ry
aXZlcnMvdmlkZW8vY29uc29sZS9mYmNvbi5jCTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAwMDAwMDAw
ICswMjAwCisrKyAyLjYuMTMtZmJjb24tbG9nby1zY3JvbGwtZG93bi9kcml2ZXJzL3ZpZGVvL2Nv
bnNvbGUvZmJjb24uYwkyMDA1LTA5LTA3IDExOjE1OjQ0LjAwMDAwMDAwMCArMDIwMApAQCAtMTY2
Miw2ICsxNjYyLDggQEAgc3RhdGljIGludCBmYmNvbl9zY3JvbGwoc3RydWN0IHZjX2RhdGEgKgog
CWNhc2UgU01fRE9XTjoKIAkJaWYgKGNvdW50ID4gdmMtPnZjX3Jvd3MpCS8qIE1heGltdW0gcmVh
bGlzdGljIHNpemUgKi8KIAkJCWNvdW50ID0gdmMtPnZjX3Jvd3M7CisJCWlmIChsb2dvX3Nob3du
ID49IDApCisJCQlnb3RvIHJlZHJhd19kb3duOwogCQlzd2l0Y2ggKHAtPnNjcm9sbG1vZGUpIHsK
IAkJY2FzZSBTQ1JPTExfTU9WRToKIAkJCW9wcy0+Ym1vdmUodmMsIGluZm8sIHQsIDAsIHQgKyBj
b3VudCwgMCwK

--=__Part52703C15.0__=--
