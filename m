Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbVJKUQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbVJKUQf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 16:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVJKUQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 16:16:35 -0400
Received: from BACHE.ECE.CMU.EDU ([128.2.129.23]:4577 "EHLO bache.ece.cmu.edu")
	by vger.kernel.org with ESMTP id S1751020AbVJKUQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 16:16:34 -0400
Message-ID: <434C1D60.2090901@cmu.edu>
Date: Tue, 11 Oct 2005 16:15:28 -0400
From: "Jonathan M. McCune" <jonmccune@cmu.edu>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Arvind Seshadri <arvinds@cs.cmu.edu>, Bryan Parno <parno@cmu.edu>
Subject: using segmentation in the kernel
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms050201030202070106040901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050201030202070106040901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

We're starting work on a project for the 32-bit x86 Linux kernel that
involves using segmentation in the kernel. As a first effort, we'd
like to adjust the kernel code and data segment descriptors so that
the kernel code, and data segment, bss, heap and stack exist in linear
address range between 3GB and 4 GB. How could we implment this so that
it breaks the memory management subsystem the least (or not at all if
we are lucky ;-))?

Our current thinking is to modify only the base address and the limit
of the the kernel code and data segment descriptors (_KERNEL_CS and
_KERNEL_DS). We set the base address to 3GB and the limit to 1GB. We
would also change the kernel linker script (vmlinux.lds.S) by removing
the relocation caused by PAGE_OFFSET. This would mean that the kernel
would be linked to start at address 0 + 1MB in logical address
space. Since we would set the base address of the kernel code and data
segment descriptors to 3GB, the processor would translate all
addresses emitted by the kernel so that the kernel would use addresses
of 3GB + 1MB and above in the linear address space. Hopefully, this
would mean that the all the paging code in the kernel would continue
to work correctly.

We do not understand the mm subsystem well enough to figure out if our
method would work at all or if it works what things in the mm
subsystem would be likely to break. Can someone who understands the mm
subsystem please help us here?


Thanks!
-Jon


--------------ms050201030202070106040901
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIII6TCC
As8wggI4oAMCAQICAw2KbTANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDQxMjAyMTQzOTMxWhcNMDUxMjAyMTQzOTMx
WjBDMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSAwHgYJKoZIhvcNAQkBFhFq
b25tY2N1bmVAY211LmVkdTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOP65vWj
2XdKbiMHJz+vl/2OaX4QphBZABFmRZ1XB2ovW4iK1VaBLulMQAWeVgvk5uaLKDW+FifksE1y
97PeDb75PYwLV2gbB2GXTgM3sO4qNozYqjNxEF4kAyaPKXvnp2cBYi/6p9nVWKzyUJhmT05l
PceYHzDEEYvAPLFA+CBsiieNP5fYS9JJ5dQ5ppaSw7iPgTPSHFCKcEKyvP6oPVWdH9ZendCb
EjWdU/K5XSRY0mydprtIvFQLJjw+SENFMs3oQnRcifnp0NR/zQ9gm6K5Vg0+5lLpjgRAz9zF
dsPxx1SVUQNYsaJzmRVE/lFlBJVKIfPKiHfnl1+EAcRqlo8CAwEAAaMuMCwwHAYDVR0RBBUw
E4ERam9ubWNjdW5lQGNtdS5lZHUwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQBY
/3yrjBPjrPrOct/xnsuRtDiRg1YK7Q8TLA4oaaPrUc6+RupCKakF3BRCXKBvfhETL67yxbaw
DjszVJAhKQIQDqcBhA8iDT0XfUT6d53uSaz5abJx4Pq+ihn3SoAjzCuUbgdzdMYETxgMDnHo
DE/1bTXhRSHMXRATdrKkJnkSdjCCAs8wggI4oAMCAQICAw2KbTANBgkqhkiG9w0BAQQFADBi
MQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEs
MCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDQxMjAy
MTQzOTMxWhcNMDUxMjAyMTQzOTMxWjBDMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVt
YmVyMSAwHgYJKoZIhvcNAQkBFhFqb25tY2N1bmVAY211LmVkdTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAOP65vWj2XdKbiMHJz+vl/2OaX4QphBZABFmRZ1XB2ovW4iK1VaB
LulMQAWeVgvk5uaLKDW+FifksE1y97PeDb75PYwLV2gbB2GXTgM3sO4qNozYqjNxEF4kAyaP
KXvnp2cBYi/6p9nVWKzyUJhmT05lPceYHzDEEYvAPLFA+CBsiieNP5fYS9JJ5dQ5ppaSw7iP
gTPSHFCKcEKyvP6oPVWdH9ZendCbEjWdU/K5XSRY0mydprtIvFQLJjw+SENFMs3oQnRcifnp
0NR/zQ9gm6K5Vg0+5lLpjgRAz9zFdsPxx1SVUQNYsaJzmRVE/lFlBJVKIfPKiHfnl1+EAcRq
lo8CAwEAAaMuMCwwHAYDVR0RBBUwE4ERam9ubWNjdW5lQGNtdS5lZHUwDAYDVR0TAQH/BAIw
ADANBgkqhkiG9w0BAQQFAAOBgQBY/3yrjBPjrPrOct/xnsuRtDiRg1YK7Q8TLA4oaaPrUc6+
RupCKakF3BRCXKBvfhETL67yxbawDjszVJAhKQIQDqcBhA8iDT0XfUT6d53uSaz5abJx4Pq+
ihn3SoAjzCuUbgdzdMYETxgMDnHoDE/1bTXhRSHMXRATdrKkJnkSdjCCAz8wggKooAMCAQIC
AQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENh
cGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAm
BgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0
ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1h
aWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNV
BAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQD
EyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTCBnzANBgkqhkiG9w0BAQEF
AAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me7L3N9VvyGna9fww6YfK/Uc4B
1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r1fOCdz0Dviv+uxg+B79A
gAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCBkTASBgNVHRMBAf8E
CDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhhd3RlLmNvbS9UaGF3
dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNVHREEIjAgpB4wHDEa
MBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQADgYEASIzRUIPqCy7M
DaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUa
C4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpbNU1341YheILcIRk1
3iSx0x1G/11fZU8xggM7MIIDNwIBATBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3
dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJl
ZW1haWwgSXNzdWluZyBDQQIDDYptMAkGBSsOAwIaBQCgggGnMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA1MTAxMTIwMTUyOFowIwYJKoZIhvcNAQkEMRYE
FGAgZydV3BcyWLoxt/5gpd1MKDbVMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcNAwcwDgYI
KoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMHgG
CSsGAQQBgjcQBDFrMGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0
aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1
aW5nIENBAgMNim0wegYLKoZIhvcNAQkQAgsxa6BpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQK
ExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29u
YWwgRnJlZW1haWwgSXNzdWluZyBDQQIDDYptMA0GCSqGSIb3DQEBAQUABIIBAFnJmPnglxJ2
QtU6Jlr5d4GXtnzUQHPhjJW4WO21pHSXrD7huER+QGgrTnQOAzGRM3nuuK5KMfCkhcFVA7PO
zHQre8CqpPX/Ed2gZj8esXKJTtTVXL56zyNTn+9mIM8GVWracHfgTQkLWut2ZuqLhdWRF/F0
mQ76YQo1s8iWoHVm88EO2k6se7imefaN7MZHft6HKA1rQNMmbP+gUcEbTXTP72tl4QSfkqJy
O3gzyzeb/GYSl91ItWq0N8de2pTYljsmDOP7GaH1l6+vlkTrWFB8pTK47Sy28I7kcShOlLAe
ykLxRddCfMRWJstzRoNa8rfYUkkjuSSyObAOihlsU1UAAAAAAAA=
--------------ms050201030202070106040901--
