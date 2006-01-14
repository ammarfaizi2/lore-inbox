Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbWANLV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbWANLV0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 06:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932744AbWANLV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 06:21:26 -0500
Received: from cac94-1-81-57-151-96.fbx.proxad.net ([81.57.151.96]:1160 "EHLO
	localhost") by vger.kernel.org with ESMTP id S932529AbWANLVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 06:21:25 -0500
Message-ID: <43C8DF0E.4040402@free.fr>
Date: Sat, 14 Jan 2006 12:22:54 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: greg@kroah.com
CC: linux-kernel@vger.kernel.org, usbatm@lists.infradead.org,
       linux-usb-devel@lists.sourceforge.net, ueagle <ueagleatm-dev@gna.org>
Subject: [PATCH 1/2] UEAGLE : add iso support
Content-Type: multipart/mixed;
 boundary="------------000909030004020501010103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000909030004020501010103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This patch adds the support for isochronous pipe.

A new module parameter is added to select iso mode.
It is set to iso by default because bulk mode doesn't work well at high 
speed rate (>3 Mbps for upload).

We use UDSL_IGNORE_EILSEQ flags because ADI firmware doesn't reply to 
ISO IN when it has nothing to send [1].


[1]
from cypress datasheet :

The ISOSEND0 Bit (bit 7 in the USBPAIR Register) is used when the EZ-USB 
FX chip receives an
isochronous IN token while the IN FIFO is empty. If ISOSEND0=0 (the 
default value), the USB
core does not respond to the IN token. If ISOSEND0=1, the USB core sends 
a zero-length data
packet in response to the IN token. The action to take depends on the 
overall system design. The
ISOSEND0 Bit applies to all of the isochronous IN endpoints, IN-8 
through IN-15.



Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>

--------------000909030004020501010103
Content-Type: text/plain;
 name="ueagle_iso"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="ueagle_iso"

LS0tIExpbnV4MS9kcml2ZXJzL3VzYi9hdG0vdWVhZ2xlLWF0bS5jCTIwMDYtMDEtMTQgMTI6
MDU6NTguMDAwMDAwMDAwICswMTAwCisrKyBMaW51eC9kcml2ZXJzL3VzYi9hdG0vdWVhZ2xl
LWF0bS5jCTIwMDYtMDEtMTQgMTI6MDc6MjkuMDAwMDAwMDAwICswMTAwCkBAIC02Nyw3ICs2
Nyw3IEBACiAKICNpbmNsdWRlICJ1c2JhdG0uaCIKIAotI2RlZmluZSBFQUdMRVVTQlZFUlNJ
T04gInVlYWdsZSAxLjEiCisjZGVmaW5lIEVBR0xFVVNCVkVSU0lPTiAidWVhZ2xlIDEuMiIK
IAogCiAvKgpAQCAtMzYzLDExICszNjMsMTQgQEAKIAogc3RhdGljIGludCBtb2RlbV9pbmRl
eDsKIHN0YXRpYyB1bnNpZ25lZCBpbnQgZGVidWc7CitzdGF0aWMgaW50IHVzZV9pc29bTkJf
TU9ERU1dID0ge1swIC4uLiAoTkJfTU9ERU0gLSAxKV0gPSAxfTsKIHN0YXRpYyBpbnQgc3lu
Y193YWl0W05CX01PREVNXTsKIHN0YXRpYyBjaGFyICpjbXZfZmlsZVtOQl9NT0RFTV07CiAK
IG1vZHVsZV9wYXJhbShkZWJ1ZywgdWludCwgMDY0NCk7CiBNT0RVTEVfUEFSTV9ERVNDKGRl
YnVnLCAibW9kdWxlIGRlYnVnIGxldmVsICgwPW9mZiwxPW9uLDI9dmVyYm9zZSkiKTsKK21v
ZHVsZV9wYXJhbV9hcnJheSh1c2VfaXNvLCBib29sLCBOVUxMLCAwNjQ0KTsKK01PRFVMRV9Q
QVJNX0RFU0ModXNlX2lzbywgInVzZSBpc29jaHJvbm91cyB1c2IgcGlwZSBmb3IgaW5jb21p
bmcgdHJhZmZpYyIpOwogbW9kdWxlX3BhcmFtX2FycmF5KHN5bmNfd2FpdCwgYm9vbCwgTlVM
TCwgMDY0NCk7CiBNT0RVTEVfUEFSTV9ERVNDKHN5bmNfd2FpdCwgIndhaXQgdGhlIHN5bmNo
cm9uaXNhdGlvbiBiZWZvcmUgc3RhcnRpbmcgQVRNIik7CiBtb2R1bGVfcGFyYW1fYXJyYXko
Y212X2ZpbGUsIGNoYXJwLCBOVUxMLCAwNjQ0KTsKQEAgLTkzNSw2ICs5MzgsNyBAQAogCSAq
IEFESTkzMCBkb24ndCBzdXBwb3J0IGl0ICgtRVBJUEUgZXJyb3IpLgogCSAqLwogCWlmIChV
RUFfQ0hJUF9WRVJTSU9OKHNjKSAhPSBBREk5MzAKKwkJICAgICYmICF1c2VfaXNvW3NjLT5t
b2RlbV9pbmRleF0KIAkJICAgICYmIHNjLT5zdGF0cy5waHkuZHNyYXRlICE9IChkYXRhID4+
IDE2KSAqIDMyKSB7CiAJCS8qIE9yaWdpbmFsIHRpbW1pbmcgZnJvbSBBREkodXNlZCBpbiB3
aW5kb3dzIGRyaXZlcikKIAkJICogMHgyMGZmZmY+PjE2ICogMzIgPSAzMiAqIDMyID0gMU1i
aXRzCkBAIC0xNjU4LDYgKzE2NjIsMjUgQEAKIAlzYy0+bW9kZW1faW5kZXggPSAobW9kZW1f
aW5kZXggPCBOQl9NT0RFTSkgPyBtb2RlbV9pbmRleCsrIDogMDsKIAlzYy0+ZHJpdmVyX2lu
Zm8gPSBpZC0+ZHJpdmVyX2luZm87CiAKKwkvKiBBREk5MzAgZG9uJ3Qgc3VwcG9ydCBpc28g
Ki8KKwlpZiAoVUVBX0NISVBfVkVSU0lPTihpZCkgIT0gQURJOTMwICYmIHVzZV9pc29bc2Mt
Pm1vZGVtX2luZGV4XSkgeworCQlpbnQgaTsKKworCQkvKiB0cnkgc2V0IGZhc3Rlc3QgYWx0
ZXJuYXRlIGZvciBpbmJvdW5kIHRyYWZmaWMgaW50ZXJmYWNlICovCisJCWZvciAoaSA9IEZB
U1RFU1RfSVNPX0lOVEY7IGkgPiAwOyBpLS0pCisJCQlpZiAodXNiX3NldF9pbnRlcmZhY2Uo
dXNiLCBVRUFfRFNfSUZBQ0VfTk8sIGkpID09IDApCisJCQkJYnJlYWs7CisKKwkJaWYgKGkg
PiAwKSB7CisJCQl1ZWFfZGJnKHVzYiwgInNldCBhbHRlcm5hdGUgJWQgZm9yIDIgaW50ZXJm
YWNlXG4iLCBpKTsKKwkJCXVlYV9pbmZvKHVzYiwgInVzaW5nIGlzbyBtb2RlXG4iKTsKKwkJ
CXVzYmF0bS0+ZmxhZ3MgfD0gVURTTF9VU0VfSVNPQyB8IFVEU0xfSUdOT1JFX0VJTFNFUTsK
KwkJfSBlbHNlIHsKKwkJCXVlYV9lcnIodXNiLCAic2V0dGluZyBhbnkgYWx0ZXJuYXRlIGZh
aWxlZCBmb3IgIgorCQkJCQkiMiBpbnRlcmZhY2UsIHVzaW5nIGJ1bGsgbW9kZVxuIik7CisJ
CX0KKwl9CisKIAlyZXQgPSB1ZWFfYm9vdChzYyk7CiAJaWYgKHJldCA8IDApIHsKIAkJa2Zy
ZWUoc2MpOwpAQCAtMTcwNyw2ICsxNzMwLDcgQEAKIAkuaGVhdnlfaW5pdCA9IHVlYV9oZWF2
eSwKIAkuYnVsa19pbiA9IFVFQV9CVUxLX0RBVEFfUElQRSwKIAkuYnVsa19vdXQgPSBVRUFf
QlVMS19EQVRBX1BJUEUsCisJLmlzb2NfaW4gPSBVRUFfSVNPX0RBVEFfUElQRSwKIH07CiAK
IHN0YXRpYyBpbnQgdWVhX3Byb2JlKHN0cnVjdCB1c2JfaW50ZXJmYWNlICppbnRmLCBjb25z
dCBzdHJ1Y3QgdXNiX2RldmljZV9pZCAqaWQpCg==
--------------000909030004020501010103--
