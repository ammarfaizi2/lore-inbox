Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUCBGwr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 01:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUCBGwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 01:52:46 -0500
Received: from kendy.up.ac.za ([137.215.101.101]:8493 "EHLO kendy.up.ac.za")
	by vger.kernel.org with ESMTP id S261497AbUCBGwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 01:52:39 -0500
Message-ID: <40442F2B.9090704@cs.up.ac.za>
Date: Tue, 02 Mar 2004 08:52:27 +0200
From: Jaco Kroon <jkroon@cs.up.ac.za>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
CC: David Lang <david.lang@digitalinsight.com>, Adrian Bunk <bunk@fs.tum.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3 adaptec I2O will not compile
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F38CF74@otce2k03.adaptec.com>
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F38CF74@otce2k03.adaptec.com>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms070906060406010806050504"
X-Scan-Signature: 945d5509b7d373b563d9ae71f1232176
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms070906060406010806050504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Eek, that does not bear good.  Somebody else mailed me this patch, so 
would you mind sending me your orriginal patch for comparison?

And I assume that the scsi_unregister call should in fact not be in 
there?  If I understand it correctly there is either some function that 
first calls adpt_release (from the address given in the info struct) and 
then scsi_unregister, or scsi_unregister itself calls us.

Btw, none of this code was yet incorporated into the 2.6.3 kernel which 
is why I started looking around for patches and actually looking at 
making the changes myself.  Btw, I also note that a couple of free's has 
moved around - this gives me the idea that either a memory corruption 
bug has been fixed (which leaves at least two of our machines in danger 
of crashing) or a memory leak has been introduced.  Or is it simply that 
memory handling has been optimized a bit?

Jaco

Salyzyn, Mark wrote:

>My code fragment has (original multiversion and version in 2.4.24):
>
>/*
> * scsi_unregister will be called AFTER we return.
> */
>static int adpt_release(struct Scsi_Host *host)
>{
>        adpt_hba* pHba = (adpt_hba*) host->hostdata[0];
>//      adpt_i2o_quiesce_hba(pHba);
>        adpt_i2o_delete_hba(pHba);
>        return 0;
>}
>
>So I am unsure as to how *that* (the scsi_unregister call) got in there
>in the 2.6.3 stream. adpt_i2o_queisce was commented out in version 2.4.5
>of the driver (Prior to the `historical documents' and at least the
>in-box driver for RH7.3). It was not part of the 2.6.2 tree I based my
>patch on and not part of the submitted 2.6 patch for the dpt_i2o driver.
>
>adpt_i2o_quiesce tells the adapter to stop all activity, including
>builds, and is a blocking command with a 4 minute timeout.
>
>Sincerely -- Mark Salyzyn
>
>-----Original Message-----
>From: David Lang [mailto:david.lang@digitalinsight.com] 
>Sent: Thursday, February 26, 2004 5:24 AM
>To: Salyzyn, Mark; Jaco Kroon
>Cc: Adrian Bunk; Linux Kernel Mailing List
>Subject: Re: 2.6.3 adaptec I2O will not compile
>
>Mark, do you have any comments on this?
>
>On Thu, 26 Feb 2004, Jaco Kroon wrote:
>
>  
>
>>Date: Thu, 26 Feb 2004 01:28:14 -0800
>>From: Jaco Kroon <jkroon@cs.up.ac.za>
>>To: David Lang <david.lang@digitalinsight.com>
>>Cc: Adrian Bunk <bunk@fs.tum.de>,
>>     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
>>Subject: Re: 2.6.3 adaptec I2O will not compile
>>
>>David Lang wrote:
>>
>>    
>>
>>>I received a post from Mark Salyzyn with a new driver that does
>>>      
>>>
>>compile,
>>    
>>
>>>he said that he has submitted the patches (I didn't get a chance to
>>>      
>>>
>try
>  
>
>>>the new kernel yet, I expect to do that shortly and will report any
>>>problems)
>>>
>>>D
>>>
>>>      
>>>
>>Somebody just mailed me a patch too, but I found the following
>>discrepancy:
>>
>>/*
>> * scsi_unregister will be called AFTER we return.
>> */
>>static int adpt_release(struct Scsi_Host *host)
>>{
>>    adpt_hba* pHba = (adpt_hba*) host->hostdata[0];
>>//  adpt_i2o_quiesce_hba(pHba);
>>    adpt_i2o_delete_hba(pHba);
>>    scsi_unregister(host);
>>    return 0;
>>}
>>
>>This is used to release the host, now read the comment, and then the
>>line just before the return.  This line was added by the patch, which
>>also commented out the quiesce line.  Is it possible to get any
>>confirmation on how this is supposed to function?
>>
>>Jaco
>>
>>===========================================
>>This message and attachments are subject to a disclaimer. Please refer
>>to www.it.up.ac.za/documentation/governance/disclaimer/ for full
>>details.
>>Hierdie boodskap en aanhangsels is aan 'n vrywaringsklousule
>>    
>>
>onderhewig.
>  
>
>>Volledige besonderhede is by
>>www.it.up.ac.za/documentation/governance/disclaimer/ beskikbaar.
>>===========================================
>>
>>
>>    
>>
>
>  
>

-- 
That that is is that that is not is not.
===========================================
This message and attachments are subject to a disclaimer. Please refer to www.it.up.ac.za/documentation/governance/disclaimer/ for full details.
Hierdie boodskap en aanhangsels is aan 'n vrywaringsklousule onderhewig. Volledige besonderhede is by www.it.up.ac.za/documentation/governance/disclaimer/ beskikbaar.
===========================================


--------------ms070906060406010806050504
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
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNDAzMDIwNjUyMjdaMCMGCSqGSIb3DQEJ
BDEWBBQrXT1YXdZAopNwQ35bSCzWlLhq4zBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMH
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIB
KDB4BgkrBgEEAYI3EAQxazBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwg
SXNzdWluZyBDQQIDC5XdMHoGCyqGSIb3DQEJEAILMWugaTBiMQswCQYDVQQGEwJaQTElMCMG
A1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAwuV3TANBgkqhkiG9w0BAQEFAASCAQBwVnj6
5x+rzonlionSWts2CZlGvQmAamsqpAdOIKBw4WFmBRfzGoLiHyBM7rQylBd4W8bZXNfWhYC3
eb0ferciKHgadiy+kF7VUFnkk812x/RgPZz4MGnKpIrsTuC/pDZPK7clDYlJn9YMAUScjKfy
SCWrJ2BnA49zKmBl3ECsqNbGpcXYiB9ulrwAorNV1IShKcLU0fzR7IqxR7/LWLY28pXvyirq
+r34OY+fJ/5F/H80Po0b1Uj7voh6ZvVdp+XDDWNHwZ4rkEhHqebl4cGzsDR6TImbtGebWSPu
yRK6o9Ne/opaKeM4odkn95ET0WLJj8d7qio8oAlQAV2CSEh0AAAAAAAA
--------------ms070906060406010806050504--
