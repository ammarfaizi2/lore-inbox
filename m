Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265028AbUETH7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265028AbUETH7m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 03:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbUETH7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 03:59:42 -0400
Received: from kendy.up.ac.za ([137.215.101.101]:55143 "EHLO kendy.up.ac.za")
	by vger.kernel.org with ESMTP id S265028AbUETH7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 03:59:36 -0400
Message-ID: <40AC653D.5060909@cs.up.ac.za>
Date: Thu, 20 May 2004 09:58:53 +0200
From: Jaco Kroon <jkroon@cs.up.ac.za>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040325
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at slab.c:1930
References: <40ABCA30.8010806@colorfullife.com>
In-Reply-To: <40ABCA30.8010806@colorfullife.com>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms060903070701040906060905"
X-Scan-Signature: a6c3e3a0d556478c846494571ea511f8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060903070701040906060905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Argh, just found this one in the logs:

May 19 09:58:18 fornax kernel BUG at slab.c:1930!
May 19 09:58:18 fornax invalid operand: 0000
May 19 09:58:18 fornax CPU:    0
May 19 09:58:18 fornax EIP:    0010:[<c01372a5>]    Not tainted
May 19 09:58:18 fornax EFLAGS: 00010002
May 19 09:58:18 fornax eax: c7d8b000   ebx: 00000000   ecx: 0000001e   
edx: c12c72b0
May 19 09:58:18 fornax esi: 00003ab6   edi: c12c72b0   ebp: c12c72b0   
esp: ca329f10
May 19 09:58:18 fornax ds: 0018   es: 0018   ss: 0018
May 19 09:58:18 fornax Process vmstat (pid: 27441, stackpage=ca329000)
May 19 09:58:18 fornax Stack: cb69a7e0 c02724f2 0000007c 0000003e 
000047ce 00000200 00000a42 00000a42
May 19 09:58:18 fornax 00000001 c0000000 000001f5 00000246 00001000 
00000000 000047ce 00000000
May 19 09:58:18 fornax cb69a7e0 c12c72b0 00000756 c015e8e3 cb69a7e0 
c12c72b0 ca329f74 cb69a7f8
May 19 09:58:18 fornax Call Trace:    [<c015e8e3>] [<c0140d27>] [<c010773f>]
May 19 09:58:18 fornax
May 19 09:58:18 fornax Code: 0f 0b 8a 07 bc 24 27 c0 ff 44 24 28 01 ce 
8b 00 39 e8 75 e7

but no trace of the other one, which was deffinately a lockd process 
(nfs related afaik).  Oh well, thanks for the help.  At least this 
confirms (for me at least) that there is a problem in the server side 
nfs code.  And now I know about ksymoops.

Jaco

Manfred Spraul wrote:

> Hi,
>
>> The following OOPS occured this morning.  This is on a dual CPU 
>> machine, there were two oopses, unfortunately the other scrolled off 
>> the screen but the process was lockd (nfs related afaik).
>>  
>>
> Unfortunately the first one is the important one :-(
>
>> Here is the oops (written off and typed up), unfortunately I don't 
>> know how to convert this to nicely readable symbols ...
>>
>> Kernel BUG at slab.c:1930
>>
> That's an oops caused by a consistency check while printing 
> /proc/slabinfo. Probably a side effect of the first oops.
>
> -- 
>    Manfred
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
As long as there are ill-defined goals, bizarre bugs, and unrealistic 
schedules, there will be Real Programmers willing to jump in and Solve 
The Problem, saving the documentation for later.
===========================================
This message and attachments are subject to a disclaimer. Please refer to www.it.up.ac.za/documentation/governance/disclaimer/ for full details.
Hierdie boodskap en aanhangsels is aan 'n vrywaringsklousule onderhewig. Volledige besonderhede is by www.it.up.ac.za/documentation/governance/disclaimer/ beskikbaar.
===========================================


--------------ms060903070701040906060905
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIII7TCC
AtEwggI6oAMCAQICAwuV3TANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDQwMTI4MTMxNTM0WhcNMDUwMTI3MTMxNTM0
WjBEMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSEwHwYJKoZIhvcNAQkBFhJq
a3Jvb25AY3MudXAuYWMuemEwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDGM68H
Bm8eLZzRqFlPks3sjEOAQrolKEESLKGNAL6Pu+KUMRQ9wC5feaXfg5wmVBe6VLhTY9pkiVJi
mTX1VrHdJgnvqkKfjQrPn66oAqUlytHCSB6s5SmIquw1Nu4rMK5D+/LMqV73iTEyP/2p9GbK
w9h3xmqn3HytZfqgK/Zh8SKhjRzAE+PT2aVSBL43RetHgn4CRKVacERTLYK2Gfv5jhljPuSE
6ppfVOq/Jm/tduG/xn92wWlIOL8oPq4dQcy5wYjg9nrImwM7tFlD22iY0IESSqKTe2EkhcUY
rpc+M3XZEU7bz+sSTG7MbXNfkfn+4G92KN7Z9hhex1QAxBfnAgMBAAGjLzAtMB0GA1UdEQQW
MBSBEmprcm9vbkBjcy51cC5hYy56YTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBAUAA4GB
AKItHT03yxemitMQFThOBwjiQrPwKqF5lqskzUY467RLA+6EBki+6MtGnv6yhwrOaV7H4BE3
p7gpVXtQZBlmHfZnK2l5C56OSdahZ77ti7+qsft7t1z+DyUUWCuRxA5hy4xXKgqd9cwy6mEp
uU7muCasFm9FR6H5vQbkCHH1DmjqMIIC0TCCAjqgAwIBAgIDC5XdMA0GCSqGSIb3DQEBBAUA
MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQu
MSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTAeFw0wNDAx
MjgxMzE1MzRaFw0wNTAxMjcxMzE1MzRaMEQxHzAdBgNVBAMTFlRoYXd0ZSBGcmVlbWFpbCBN
ZW1iZXIxITAfBgkqhkiG9w0BCQEWEmprcm9vbkBjcy51cC5hYy56YTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMYzrwcGbx4tnNGoWU+SzeyMQ4BCuiUoQRIsoY0Avo+74pQx
FD3ALl95pd+DnCZUF7pUuFNj2mSJUmKZNfVWsd0mCe+qQp+NCs+frqgCpSXK0cJIHqzlKYiq
7DU27iswrkP78sypXveJMTI//an0ZsrD2HfGaqfcfK1l+qAr9mHxIqGNHMAT49PZpVIEvjdF
60eCfgJEpVpwRFMtgrYZ+/mOGWM+5ITqml9U6r8mb+124b/Gf3bBaUg4vyg+rh1BzLnBiOD2
esibAzu0WUPbaJjQgRJKopN7YSSFxRiulz4zddkRTtvP6xJMbsxtc1+R+f7gb3Yo3tn2GF7H
VADEF+cCAwEAAaMvMC0wHQYDVR0RBBYwFIESamtyb29uQGNzLnVwLmFjLnphMAwGA1UdEwEB
/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEAoi0dPTfLF6aK0xAVOE4HCOJCs/AqoXmWqyTNRjjr
tEsD7oQGSL7oy0ae/rKHCs5pXsfgETenuClVe1BkGWYd9mcraXkLno5J1qFnvu2Lv6qx+3u3
XP4PJRRYK5HEDmHLjFcqCp31zDLqYSm5Tua4JqwWb0VHofm9BuQIcfUOaOowggM/MIICqKAD
AgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVy
biBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5n
MSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZy
ZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQsw
CQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoG
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcN
AQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHy
v1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsY
Pge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0T
AQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20v
VGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQe
MBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD
6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZ
GwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC
3CEZNd4ksdMdRv9dX2VPMYIDOzCCAzcCAQEwaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMc
VGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFs
IEZyZWVtYWlsIElzc3VpbmcgQ0ECAwuV3TAJBgUrDgMCGgUAoIIBpzAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNDA1MjAwNzU4NTNaMCMGCSqGSIb3DQEJ
BDEWBBSjI5RJMhnLPcITe6pnLen/rwU8/DBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMH
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIB
KDB4BgkrBgEEAYI3EAQxazBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwg
SXNzdWluZyBDQQIDC5XdMHoGCyqGSIb3DQEJEAILMWugaTBiMQswCQYDVQQGEwJaQTElMCMG
A1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAwuV3TANBgkqhkiG9w0BAQEFAASCAQCksf8v
JAUJdUfSW18yKG3+Cgv7D5eYnENt/8e4S+mKOULJusglqziPA7XbpB0kNzRVzt6p54S587MI
DOxYgucZwoMbMzU99ITFu9hJI8NTK5xVMMKypEb2tEzc0+t7Tl5fhQkI7yNikOMu1XnxPywY
wXurpqddIjn2YTqOu8c73xWKmVq3dx/IgQxYGhP3tvW+4NPRCRuK9Es+e/laA8ClPS3CIWbU
ng8sJvkEl+haU8y3jXJRQ2qGgZZEpNFDVfarochAvD6jx+0OTFFBbDyqDpbijGMDmrRMsn2z
g9SRMSvJPXrPevdxqjkiGZMhj1sm7xtiXuYdx6J2CS66DoIUAAAAAAAA
--------------ms060903070701040906060905--
