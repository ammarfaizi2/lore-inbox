Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265019AbUETIKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265019AbUETIKw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 04:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265036AbUETIKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 04:10:52 -0400
Received: from kendy.up.ac.za ([137.215.101.101]:8828 "EHLO kendy.up.ac.za")
	by vger.kernel.org with ESMTP id S265019AbUETIKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 04:10:45 -0400
Message-ID: <40AC67F8.5010307@cs.up.ac.za>
Date: Thu, 20 May 2004 10:10:32 +0200
From: Jaco Kroon <jkroon@cs.up.ac.za>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040325
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: samg@seven4sky.com
CC: linux-kernel@vger.kernel.org
Subject: Re: NFS deadlock
References: <40A9E239.4010909@cs.up.ac.za> <1231.128.150.143.219.1084982960.squirrel@webmail.seven4sky.com>
In-Reply-To: <1231.128.150.143.219.1084982960.squirrel@webmail.seven4sky.com>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms080608060707060606040403"
X-Scan-Signature: fa3a536f1d4c9df3e54aea02fbf54b4d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms080608060707060606040403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Oh, sorry.

The one box at home is running 2.6.5 currently with the intent of 
upgrading to 2.6.6 as soon as I can find the time.  It is using an ext3 
file system underlying.  The same goes to the single client it serves to.

The one at the office that serves up to a hundred or so clients 
currently runs 2.6.4 with a patch for the dpt_i2o driver, it has an ext3 
partition but the one being served up via nfs is reiserfs.  The clients 
are running 2.6.5 at the moment (anything between 0 and 320 clients max 
at any time, usually between 20 and 50 clients depending on lab usage).  
The other server is using 2.4.24 (waiting for the dpt_i2o driver in the 
2.6 kernel) with ext3 file systems and once again reiserfs for the nfs 
exported part of the file system.  Variety of clients in this case, from 
2.4.20 kernels, right through to 2.6.6 kernels.

The machine that died yesterday is also running a 2.6.5 kernel, ext3 
file system.  It's two clients is the first of the two servers above and 
the other runs kernel 2.6.6 as well.

What affects the regulularity of the crashes seems to be the load placed 
on it by clients.  In my case at home the client is considerably faster 
that the server, which will enforce a relatively high load.  I wish I 
had more time to check this out. I'm suspecting some kind of race 
condition that gets triggered by either heavy system load or a heavy 
skew between speeds on the client/server.  I might be totally wrong 
though ...

Transfers in our case is always between linus and linux (at least as far 
as we can control it, we are not aware of any other clients and would 
probably manage to get such a person expelled should we find him).

The client lock-ups we've experienced as well.  It eventually times out 
after a *long* time, we usually bounce the server before that happens. 
This can be explained and is in my oppinion quite normal.

What does sysstat and sar do?  How can I use them to analyse the problem?

Jaco

samg@seven4sky.com wrote:

>Jaco,
>
>How are your boxes locking up, I have nfs in use every day,
>does rpc die?
>
>what kernel are you using?
>and are you transfering linux to linux, or to some other platform.
>
>The only time I had problems was when my client locked up
>because I disconnected the server, and it hung the client,
>the only solution (based on the way I connected), was to reboot.
>To make matters worse, I rean a script that used du every day, and
>so there were 12+ instances of du, all trying to run about.
>
>I would suggest using a program like sysstat, or sar, to help you
>analyse the issues at hand.
>
> -sam
>
>  
>
>>Hello there
>>
>>I've once again got problems with the kernel locking up.  I'm now
>>convinced that it has something to do with NFS.
>>
>>Previously weve had 2 machines that locked up, plus my one at home,
>>resulting in three machines.  Sometimes they would recover by themselves
>>after some time, other times they could be left for 2 days or so without
>>recovering.  All three of these use NFS to export files to other
>>machines, it's the only thing we can find they have in common, other
>>that x86 architecture, but then other machines would be dying as well.
>>It should be noted that none of these runs on the newest hardware, but
>>that should not matter, neither does any of our other servers.  We have
>>a 3rd NFS server, which doesn't take nearly as heavy load via NFS.  I've
>>been wondering why it hasn't locked up either, and this morning (right
>>now in fact) it has decided that it is it's turn and is currently
>>unusable.
>>
>>If anybody else is experiencing similar problems, or have possible work
>>arounds, it would be appreciated if you could share your knowledge.
>>
>>Jaco
>>
>>===========================================
>>This message and attachments are subject to a disclaimer. Please refer to
>>www.it.up.ac.za/documentation/governance/disclaimer/ for full details.
>>Hierdie boodskap en aanhangsels is aan 'n vrywaringsklousule onderhewig.
>>Volledige besonderhede is by
>>www.it.up.ac.za/documentation/governance/disclaimer/ beskikbaar.
>>===========================================
>>
>>
>>    
>>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

-- 
"The strength of the Constitution lies entirely in the determination of each
citizen to defend it.  Only if every single citizen feels duty bound to do
his share in this defense are the constitutional rights secure."
-- Albert Einstein
===========================================
This message and attachments are subject to a disclaimer. Please refer to www.it.up.ac.za/documentation/governance/disclaimer/ for full details.
Hierdie boodskap en aanhangsels is aan 'n vrywaringsklousule onderhewig. Volledige besonderhede is by www.it.up.ac.za/documentation/governance/disclaimer/ beskikbaar.
===========================================


--------------ms080608060707060606040403
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
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNDA1MjAwODEwMzJaMCMGCSqGSIb3DQEJ
BDEWBBSRfH+vqc1TCnKdOMpbixDVfO4hszBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMH
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIB
KDB4BgkrBgEEAYI3EAQxazBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwg
SXNzdWluZyBDQQIDC5XdMHoGCyqGSIb3DQEJEAILMWugaTBiMQswCQYDVQQGEwJaQTElMCMG
A1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAwuV3TANBgkqhkiG9w0BAQEFAASCAQAgR7wy
OzvyQsjEOEXQzEt5T0djFo3FF/hzLHu2zN0k+hEw0tpepATq7C+H5KWandgi2KCh6nlp3Ktt
ljP4lEV4JoJp6AKefF+Nhz/4wqsRQ9pdVXKFJ1fl+Bz2b/XybrlacvXUBUxzqSJbC4jnlsGW
oX4S42X0IzvMZzynZi4YOHETWdYIAlPcWPEQrltaIcMUmwdrDQvarNn86hVYSWCIitcgMdpj
FCQvSbMx09efbvBKFXzA0GD8ScmhnqF67UCHAdm1ex8lfKo+v0g7RgilEC0JTet8SEAzvkmV
5BWeBmuMlde7wqIHgP1YWY03Il0AuWx8g0TXdfWOkxMtBpTPAAAAAAAA
--------------ms080608060707060606040403--
