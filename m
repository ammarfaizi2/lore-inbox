Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262409AbUKVWDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbUKVWDO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbUKVWCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:02:20 -0500
Received: from f05s05.cac.psu.edu ([128.118.141.48]:12425 "EHLO
	authsmtp.psu.edu") by vger.kernel.org with ESMTP id S262399AbUKVV6i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 16:58:38 -0500
Message-ID: <41A26108.80601@psu.edu>
Date: Mon, 22 Nov 2004 16:58:32 -0500
From: Phil Sorber <aafes@psu.edu>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041114)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ayyappan.veeraiyan@intel.com, ganesh.venkatesan@intel.com,
       john.ronciak@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ixgb Intel 10GE driver
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms050408020103000402040803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050408020103000402040803
Content-Type: multipart/mixed;
 boundary="------------010904070702050709010205"

This is a multi-part message in MIME format.
--------------010904070702050709010205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is a patch against 2.6.8.1 that enables the ixgb driver to be used for LR 
cards as well. I have attatched a file and pasted it into this email.

------------------------------SNIP--------------------------------

diff -uNr linux-2.6.8.1/drivers/net/ixgb/ixgb_hw.c 
linux-2.6.8.1-fix/drivers/net/ixgb/ixgb_hw.c
--- linux-2.6.8.1/drivers/net/ixgb/ixgb_hw.c    2004-08-14 06:55:47.000000000 -0400
+++ linux-2.6.8.1-fix/drivers/net/ixgb/ixgb_hw.c        2004-11-22 
11:43:12.680602928 -0500
@@ -198,6 +198,7 @@
                 break;

         case IXGB_DEVICE_ID_82597EX_SR:
+       case IXGB_DEVICE_ID_82597EX_LR:
                 /* The SR adapters carry two different types of XPAK optics
                  * modules; read the vendor identifier to determine the exact
                  * type of optics. */
diff -uNr linux-2.6.8.1/drivers/net/ixgb/ixgb_ids.h 
linux-2.6.8.1-fix/drivers/net/ixgb/ixgb_ids.h
--- linux-2.6.8.1/drivers/net/ixgb/ixgb_ids.h   2004-08-14 06:55:32.000000000 -0400
+++ linux-2.6.8.1-fix/drivers/net/ixgb/ixgb_ids.h       2004-11-22 
11:42:46.460588976 -0500
@@ -38,6 +38,7 @@

  #define IXGB_DEVICE_ID_82597EX      0x1048
  #define IXGB_DEVICE_ID_82597EX_SR   0x1A48
+#define IXGB_DEVICE_ID_82597EX_LR   0x1B48

  #define IXGB_SUBDEVICE_ID_A11F  0xA11F
  #define IXGB_SUBDEVICE_ID_A01F  0xA01F
diff -uNr linux-2.6.8.1/drivers/net/ixgb/ixgb_main.c 
linux-2.6.8.1-fix/drivers/net/ixgb/ixgb_main.c
--- linux-2.6.8.1/drivers/net/ixgb/ixgb_main.c  2004-08-14 06:54:51.000000000 -0400
+++ linux-2.6.8.1-fix/drivers/net/ixgb/ixgb_main.c      2004-11-22 
11:42:57.173960296 -0500
@@ -46,6 +46,8 @@
          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
         {INTEL_VENDOR_ID, IXGB_DEVICE_ID_82597EX_SR,
          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+       {INTEL_VENDOR_ID, IXGB_DEVICE_ID_82597EX_LR,
+        PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},

         /* required last entry */
         {0,}
@@ -484,7 +486,8 @@
         hw->max_frame_size = netdev->mtu + ENET_HEADER_SIZE + ENET_FCS_LENGTH;

         if ((hw->device_id == IXGB_DEVICE_ID_82597EX)
-           || (hw->device_id == IXGB_DEVICE_ID_82597EX_SR))
+           || (hw->device_id == IXGB_DEVICE_ID_82597EX_SR)
+           || (hw->device_id == IXGB_DEVICE_ID_82597EX_LR))
                 hw->mac_type = ixgb_82597;
         else {
                 /* should never have loaded on this device */

----------------------------SNIP------------------------------

-- 
Phil Sorber                                                       814.863.9447
/.../its/aset/gears/hpc/phil                            214E Computer Building


--------------010904070702050709010205
Content-Type: text/plain;
 name="ixgb-lr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ixgb-lr.patch"

diff -uNr linux-2.6.8.1/drivers/net/ixgb/ixgb_hw.c linux-2.6.8.1-fix/drivers/net/ixgb/ixgb_hw.c
--- linux-2.6.8.1/drivers/net/ixgb/ixgb_hw.c	2004-08-14 06:55:47.000000000 -0400
+++ linux-2.6.8.1-fix/drivers/net/ixgb/ixgb_hw.c	2004-11-22 11:43:12.680602928 -0500
@@ -198,6 +198,7 @@
 		break;
 
 	case IXGB_DEVICE_ID_82597EX_SR:
+	case IXGB_DEVICE_ID_82597EX_LR:
 		/* The SR adapters carry two different types of XPAK optics
 		 * modules; read the vendor identifier to determine the exact
 		 * type of optics. */
diff -uNr linux-2.6.8.1/drivers/net/ixgb/ixgb_ids.h linux-2.6.8.1-fix/drivers/net/ixgb/ixgb_ids.h
--- linux-2.6.8.1/drivers/net/ixgb/ixgb_ids.h	2004-08-14 06:55:32.000000000 -0400
+++ linux-2.6.8.1-fix/drivers/net/ixgb/ixgb_ids.h	2004-11-22 11:42:46.460588976 -0500
@@ -38,6 +38,7 @@
 
 #define IXGB_DEVICE_ID_82597EX      0x1048
 #define IXGB_DEVICE_ID_82597EX_SR   0x1A48
+#define IXGB_DEVICE_ID_82597EX_LR   0x1B48
 
 #define IXGB_SUBDEVICE_ID_A11F  0xA11F
 #define IXGB_SUBDEVICE_ID_A01F  0xA01F
diff -uNr linux-2.6.8.1/drivers/net/ixgb/ixgb_main.c linux-2.6.8.1-fix/drivers/net/ixgb/ixgb_main.c
--- linux-2.6.8.1/drivers/net/ixgb/ixgb_main.c	2004-08-14 06:54:51.000000000 -0400
+++ linux-2.6.8.1-fix/drivers/net/ixgb/ixgb_main.c	2004-11-22 11:42:57.173960296 -0500
@@ -46,6 +46,8 @@
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{INTEL_VENDOR_ID, IXGB_DEVICE_ID_82597EX_SR,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{INTEL_VENDOR_ID, IXGB_DEVICE_ID_82597EX_LR,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 
 	/* required last entry */
 	{0,}
@@ -484,7 +486,8 @@
 	hw->max_frame_size = netdev->mtu + ENET_HEADER_SIZE + ENET_FCS_LENGTH;
 
 	if ((hw->device_id == IXGB_DEVICE_ID_82597EX)
-	    || (hw->device_id == IXGB_DEVICE_ID_82597EX_SR))
+	    || (hw->device_id == IXGB_DEVICE_ID_82597EX_SR)
+	    || (hw->device_id == IXGB_DEVICE_ID_82597EX_LR))
 		hw->mac_type = ixgb_82597;
 	else {
 		/* should never have loaded on this device */

--------------010904070702050709010205--

--------------ms050408020103000402040803
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJ0TCC
Az8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQI
EwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENv
bnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAi
BgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVy
c29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5
NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBM
dGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTCBnzAN
BgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me7L3N9Vvy
Gna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r1fOC
dz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCB
kTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhh
d3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNV
HREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQAD
gYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFi
w9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpb
NU1341YheILcIRk13iSx0x1G/11fZU8wggNDMIICrKADAgECAgMNMGUwDQYJKoZIhvcNAQEE
BQAwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0
ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA0
MTAwNzE5Mzk0N1oXDTA1MTAwNzE5Mzk0N1owgZkxDzANBgNVBAQTBlNvcmJlcjEQMA4GA1UE
KhMHUGhpbGxpcDEXMBUGA1UEAxMOUGhpbGxpcCBTb3JiZXIxHDAaBgkqhkiG9w0BCQEWDWFh
ZmVzQHBzdS5lZHUxHTAbBgkqhkiG9w0BCQEWDnNvcmJlckBwc3UuZWR1MR4wHAYJKoZIhvcN
AQkBFg9waGlsQHNvcmJlci5uZXQwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCh
hvAEtV0UWnjSnfUVwY58eMGFcSIZMGATm6iu+FVAotwxsMlG0UK7EUNQIfqcaGfW61F3G2en
FlD1vpCIA96wrG1fC2g2n/c9fiEemOtrtGmajFIQCFAawu048f27TDxlIzlnaohAICPigFwg
J4TGBK7fLV+Yd0YAtHtBaXngmWwg/MYMsfVU7ojEYNZ1CJrKz8e1AwO8iXgaNUi032hNRAw/
sFMGki20emLbDM7XUBXXI3mvTjwGmTJ7KxNBy4oHqecxzgZQEqcZeds47SC2kIukxwZRNRBS
Ys44yRVRtT9LFIyTFh53Q5PyYVW7lHuq5++nihEl20KvIguq5CjvAgMBAAGjSzBJMDkGA1Ud
EQQyMDCBDWFhZmVzQHBzdS5lZHWBDnNvcmJlckBwc3UuZWR1gQ9waGlsQHNvcmJlci5uZXQw
DAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQAORUh5guH7xM6P64zrLZO/d+KddQNi
LnpgMPAfhABkbH+UUszbq53VjwrM1v19s1/1JULVAONF7FnQWQIbbMoZfyCOf+7NybFKp2iF
xkAXB+y5BxoMcvHcLw71FQOB2OLpG/zqhT0rCo/JLsjjsGAk3Bg/nenb7HhZyprwsX6/WTCC
A0MwggKsoAMCAQICAw0wZTANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDQxMDA3MTkzOTQ3WhcNMDUxMDA3MTkzOTQ3
WjCBmTEPMA0GA1UEBBMGU29yYmVyMRAwDgYDVQQqEwdQaGlsbGlwMRcwFQYDVQQDEw5QaGls
bGlwIFNvcmJlcjEcMBoGCSqGSIb3DQEJARYNYWFmZXNAcHN1LmVkdTEdMBsGCSqGSIb3DQEJ
ARYOc29yYmVyQHBzdS5lZHUxHjAcBgkqhkiG9w0BCQEWD3BoaWxAc29yYmVyLm5ldDCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKGG8AS1XRRaeNKd9RXBjnx4wYVxIhkwYBOb
qK74VUCi3DGwyUbRQrsRQ1Ah+pxoZ9brUXcbZ6cWUPW+kIgD3rCsbV8LaDaf9z1+IR6Y62u0
aZqMUhAIUBrC7Tjx/btMPGUjOWdqiEAgI+KAXCAnhMYErt8tX5h3RgC0e0FpeeCZbCD8xgyx
9VTuiMRg1nUImsrPx7UDA7yJeBo1SLTfaE1EDD+wUwaSLbR6YtsMztdQFdcjea9OPAaZMnsr
E0HLigep5zHOBlASpxl52zjtILaQi6THBlE1EFJizjjJFVG1P0sUjJMWHndDk/JhVbuUe6rn
76eKESXbQq8iC6rkKO8CAwEAAaNLMEkwOQYDVR0RBDIwMIENYWFmZXNAcHN1LmVkdYEOc29y
YmVyQHBzdS5lZHWBD3BoaWxAc29yYmVyLm5ldDAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEB
BAUAA4GBAA5FSHmC4fvEzo/rjOstk7934p11A2IuemAw8B+EAGRsf5RSzNurndWPCszW/X2z
X/UlQtUA40XsWdBZAhtsyhl/II5/7s3JsUqnaIXGQBcH7LkHGgxy8dwvDvUVA4HY4ukb/OqF
PSsKj8kuyOOwYCTcGD+d6dvseFnKmvCxfr9ZMYIDOzCCAzcCAQEwaTBiMQswCQYDVQQGEwJa
QTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhh
d3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAw0wZTAJBgUrDgMCGgUAoIIBpzAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNDExMjIyMTU4MzJa
MCMGCSqGSIb3DQEJBDEWBBQoYIX/yzVtYMFYB8psIQ2CDvvrojBSBgkqhkiG9w0BCQ8xRTBD
MAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzAN
BggqhkiG9w0DAgIBKDB4BgkrBgEEAYI3EAQxazBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQK
ExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29u
YWwgRnJlZW1haWwgSXNzdWluZyBDQQIDDTBlMHoGCyqGSIb3DQEJEAILMWugaTBiMQswCQYD
VQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAw0wZTANBgkqhkiG9w0B
AQEFAASCAQA0E26mGWyiNqrxbArfadxIvfLJW9yjOKpRXm4GWZY3l+pQ23tsMsLcwVqyw+Gn
8jywuVs0iR6UN16n2V5nV+H51AKh9TAp82gefSq0ouQT9BSU6Z97F5D5Apb/bY4TTmOzJO7q
WNnElaLwlx8nV3Why9Z3S10RrOabVNnU2Yvm0mZ6OXzfjrBm1s8HCgfU3YgWbC0VX0XlzMNe
oJUnumAl1jinQzzCRn24nZLOAw2/tVLokGGk7UsvwxrMDGeyMyQfCU6uLvYk4xw9I7et+tN+
BRBtqTU8jMVHtD5IYGtUGbr2eXR64pnTcO1/IOfL6P2RQClqfUHxROGZlbQfZo8qAAAAAAAA

--------------ms050408020103000402040803--
