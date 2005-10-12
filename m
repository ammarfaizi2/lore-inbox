Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbVJLX5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVJLX5M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 19:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbVJLX5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 19:57:12 -0400
Received: from BACHE.ECE.CMU.EDU ([128.2.129.23]:1532 "EHLO bache.ece.cmu.edu")
	by vger.kernel.org with ESMTP id S964816AbVJLX5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 19:57:11 -0400
Message-ID: <434DA288.6080603@cmu.edu>
Date: Wed, 12 Oct 2005 19:55:52 -0400
From: "Jonathan M. McCune" <jonmccune@cmu.edu>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-os@analogic.com
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org,
       Arvind Seshadri <arvinds@cs.cmu.edu>, Bryan Parno <parno@cmu.edu>,
       Mark Luk <mluk@andrew.cmu.edu>
Subject: Re: using segmentation in the kernel
References: <434C1D60.2090901@cmu.edu> <434C2269.5090209@didntduck.org>	 <434C1F8E.6080405@gmail.com>	 <1129107936.3082.34.camel@laptopd505.fenrus.org> <1129133231.7966.1.camel@localhost.localdomain>
In-Reply-To: <1129133231.7966.1.camel@localhost.localdomain>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms090506040203000905000607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms090506040203000905000607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:

>On Mer, 2005-10-12 at 11:05 +0200, Arjan van de Ven wrote:
>  
>
>>> separate modules so that they 
>>>will not affect kernel and more...
>>>      
>>>
>>and I don't believe this one yota. THe only way to do this is to run
>>modules in ring 1, at which point you are in deep shit anyway.
>>    
>>
>
>Not neccessarily. Its how Xen works on x86-32 for example. It keeps
>itself protected from the entire Linux instance by using segmentation on
>32bit processors (not 64bit however as x86-64 has no segments in 64bit)
>
>Doing that without major work on the kernel itself would be hard, and
>you'd need to isolate out things like page table updates and verify them
>whenever modules wanted to touch such stuff
>
>Alan
>
>  
>

linux-os (Dick Johnson) wrote:

>On the ix86 you have a problem. Let's say that you write some
>code from scratch, that runs the CPU in 32-bit linear address-mode
>without paging. Then you want to activate paging. To activate
>paging, you MUST have provided some code and some data-space for
>your descriptors, where there is a 1:1 mapping between virtual
>and bus addresses. If you don't do this, at the instant you
>change to paging mode, you crash. The CPU fetches garbage.
>
>This is why the first few megabytes of Linux are unity-mapped.
>You will always need to run the kernel out of an area where
>a portion of that "segment" is unity-mapped. That segment
>is where the descriptors for addressing, paging, and interrupts
>must reside.
>
>If you truly wanted to run the kernel from 3-4 GB as you state,
>you must have RAM there, i.e., some physical stuff so that
>a 1:1 mapping could be implemented. The 3-4 GB region is
>where a lot of PCI addressing occurs on 32-bit machines and,
>in fact, there are some "do-not-touch" addresses in that
>region as well.
>
>Remember that the kernel runs in virtual address mode, but
>the descriptors that specify that mode need to be in physical
>memory, addressed at the same offset. You can experiment
>by making a module that attempts to turn off paging and
>then turn it back on. The kernel will crash instantly.
>However, if you write some code somewhere in low address-
>space where the startup code already exists, that turns
>off paging, then turns it back on; and your module code
>calls this other code, the machine will work fine. You
>need the interrupts off when you play.
>
>So, basically you can't do what you want with any OS that
>uses ix86 type CPUs. The question is; "What was it that
>you really wanted to do?". What you gave us was the
>"implementation details". What I want to know is what
>you intend to accomplish. The ix86 architecture lends itself
>to a lot of interesting things so if I knew your intentions
>I might be able to help.
>
>Cheers,
>Dick Johnson
>

Hello,

Thanks for all the responses.  The project we are working on does
involve the use of Xen, so we have the advantage of Xen's taking care
of the bootstrapping hassles with "unity mapping" parts of the kernel.
To put it another way, the architecture we are really interested in is
xen-i386.  We are curious about the implications of restricting the
kernel's code and data segments such that the kernel cannot read/write
user space directly. We want to set the base address of the Kernel
segment descriptors to 3GB and the limit to 1GB-64MB ( Xen uses the
top 64 MB). We were just wondering if the best way to achieve this
would be to change the kernel linker script and the segment base
addresses appropriately. Any insight into whether this would work at
all or what would work and how to debug something like this would be
greatly appreciated.

Thanks,
-Jon


--------------ms090506040203000905000607
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
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA1MTAxMjIzNTU1MlowIwYJKoZIhvcNAQkEMRYE
FE/dKV/FEQ3Cqf7+IoFVw3H5Aq9KMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcNAwcwDgYI
KoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMHgG
CSsGAQQBgjcQBDFrMGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0
aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1
aW5nIENBAgMNim0wegYLKoZIhvcNAQkQAgsxa6BpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQK
ExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29u
YWwgRnJlZW1haWwgSXNzdWluZyBDQQIDDYptMA0GCSqGSIb3DQEBAQUABIIBAGkRdBJI0KGS
WnZwansBcDYoa7zN1AizcNsPs+Brx80k+BFBS4BnhZS6XR/n7tc4hGH12AuCd3P3RscGqkN5
LO0x9xvastQ1Gji/joBC7Ec/0MRd6BtLeK61+tL0buzFepgZMsKq1CcyPWvRQFZIPM+yYA8w
X3EW8orDeaq1R2wola983GUBpRQI6xdaihtonmbmujza1RcreVt9ozsD44so7opOJ9gC020q
1kXxxmNSvvlE0cdZ6y1Bf23BWhtreQ0tvXp6U8ntXYEzIFwfRznJQqffRcnr9VLTdDAGe0oy
1nlbrjKJc9wfBqGB7yVmDrVDjWct1VSj4fJ6ZWEkrrkAAAAAAAA=
--------------ms090506040203000905000607--
