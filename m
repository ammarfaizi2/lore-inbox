Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264901AbSJOSKm>; Tue, 15 Oct 2002 14:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264904AbSJOSKm>; Tue, 15 Oct 2002 14:10:42 -0400
Received: from mtao-m02.ehs.aol.com ([64.12.52.8]:31440 "EHLO
	mtao-m02.ehs.aol.com") by vger.kernel.org with ESMTP
	id <S264901AbSJOSKh>; Tue, 15 Oct 2002 14:10:37 -0400
Date: Tue, 15 Oct 2002 11:16:22 -0700
From: John Gardiner Myers <jgmyers@netscape.com>
Subject: Re: [PATCH] Re: [PATCH] async poll for 2.5
To: David Stevens <dlstevens@us.ibm.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       Ben LaHaise <bcrl@redhat.com>, David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Message-id: <3DAC5B76.1050101@netscape.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------ms010004000007090708020708; micalg=sha1;
 protocol="application/x-pkcs7-signature"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2a)
 Gecko/20020910
References: <OF3A9B0975.898CCB55-ON88256C53.00196AF8@boulder.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms010004000007090708020708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This looks better, but there are still some issues:

The patch arrived here with tabs expanded into spaces, so it doesn't apply.

The EAGAIN fix by Mingming Cao is obviously incomplete, as I've 
mentioned in a separate message to linux-aio.  I think it would be 
better if you would leave this out of this patch and let it be handled 
separately.

async_poll_complete() is dead code and should be removed (this was an 
issue in the original 2.4.19 code).

You should not reintroduce the ki_data member of struct iocb.  Insead 
you should use the existing private member of struct iocb.

In aio_abi.h, you should adjust the preceeding comment to remove mention 
of IOCB_CMD_POLL.

Incidentally, this patch depends on the sys_io_cancel() portion of the 
patch I posted yesterday in order for cancellation to return the correct 
result to user space.


--------------ms010004000007090708020708
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIK7TCC
A4UwggLuoAMCAQICAlvfMA0GCSqGSIb3DQEBBAUAMIGTMQswCQYDVQQGEwJVUzELMAkGA1UE
CBMCQ0ExFjAUBgNVBAcTDU1vdW50YWluIFZpZXcxGzAZBgNVBAoTEkFtZXJpY2EgT25saW5l
IEluYzEZMBcGA1UECxMQQU9MIFRlY2hub2xvZ2llczEnMCUGA1UEAxMeSW50cmFuZXQgQ2Vy
dGlmaWNhdGUgQXV0aG9yaXR5MB4XDTAyMDYwMTIwMjIyM1oXDTAyMTEyODIwMjIyM1owfTEL
MAkGA1UEBhMCVVMxGzAZBgNVBAoTEkFtZXJpY2EgT25saW5lIEluYzEXMBUGCgmSJomT8ixk
AQETB2pnbXllcnMxIzAhBgkqhkiG9w0BCQEWFGpnbXllcnNAbmV0c2NhcGUuY29tMRMwEQYD
VQQDEwpKb2huIE15ZXJzMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDsB5tbTLWFycke
FKQwy1MTNx7SFtehB26RBx2gT+6+5/sYfXuLmBOuEOU2646fK0tz4rFOXfR8TcLfxOp3anh2
3pKDAnBEOp5u75bEIwY5nteR0opdni/CTeyCfJ1uPuYdNKTYC088GwbpzhBRE8n1APHXCBgv
bnGAuuYw/BqDtwIDAQABo4H8MIH5MA4GA1UdDwEB/wQEAwIFIDAdBgNVHSUEFjAUBggrBgEF
BQcDAgYIKwYBBQUHAwQwQwYJYIZIAYb4QgENBDYWNElzc3VlZCBieSBOZXRzY2FwZSBDZXJ0
aWZpY2F0ZSBNYW5hZ2VtZW50IFN5c3RlbSA0LjUwHwYDVR0RBBgwFoEUamdteWVyc0BuZXRz
Y2FwZS5jb20wHwYDVR0jBBgwFoAUKduyLYN+f4sju8LMZrk56CnzAoYwQQYIKwYBBQUHAQEE
NTAzMDEGCCsGAQUFBzABhiVodHRwOi8vY2VydGlmaWNhdGVzLm5ldHNjYXBlLmNvbS9vY3Nw
MA0GCSqGSIb3DQEBBAUAA4GBAHhQSSAs8Vmute2hyZulGeFAZewLIz+cDGBOikFTP0/mIPmC
leog5JnWRqXOcVvQhqGg91d9imNdN6ONBE9dNkVDZPiVcgJ+J3wc+htIAc1duKc1CD3K6CM1
ouBbe4h4dhLWvyLWIcPPXNiGIBhA0PqoZlumSN3wlWdRqMaTC4P0MIIDhjCCAu+gAwIBAgIC
W+AwDQYJKoZIhvcNAQEEBQAwgZMxCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJDQTEWMBQGA1UE
BxMNTW91bnRhaW4gVmlldzEbMBkGA1UEChMSQW1lcmljYSBPbmxpbmUgSW5jMRkwFwYDVQQL
ExBBT0wgVGVjaG5vbG9naWVzMScwJQYDVQQDEx5JbnRyYW5ldCBDZXJ0aWZpY2F0ZSBBdXRo
b3JpdHkwHhcNMDIwNjAxMjAyMjIzWhcNMDIxMTI4MjAyMjIzWjB9MQswCQYDVQQGEwJVUzEb
MBkGA1UEChMSQW1lcmljYSBPbmxpbmUgSW5jMRcwFQYKCZImiZPyLGQBARMHamdteWVyczEj
MCEGCSqGSIb3DQEJARYUamdteWVyc0BuZXRzY2FwZS5jb20xEzARBgNVBAMTCkpvaG4gTXll
cnMwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMkrxhwWBuZImCjNet4bJ6Vdv/iXgHQs
oXf8wdBaJZ2X6jJ17ZzlSha9mmwt3Z9H8LFfVdS+dz29ri1fBuvf0rcxPWdZkKi6HDag2yNV
f3CV+650RlyzuQr2RNeirkKvaocmakRdplHRw81Txxoi5sCMrkVPmRWA35ILnNbn6sTvAgMB
AAGjgf0wgfowDwYDVR0PAQH/BAUDAweAADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUH
AwQwQwYJYIZIAYb4QgENBDYWNElzc3VlZCBieSBOZXRzY2FwZSBDZXJ0aWZpY2F0ZSBNYW5h
Z2VtZW50IFN5c3RlbSA0LjUwHwYDVR0RBBgwFoEUamdteWVyc0BuZXRzY2FwZS5jb20wHwYD
VR0jBBgwFoAUKduyLYN+f4sju8LMZrk56CnzAoYwQQYIKwYBBQUHAQEENTAzMDEGCCsGAQUF
BzABhiVodHRwOi8vY2VydGlmaWNhdGVzLm5ldHNjYXBlLmNvbS9vY3NwMA0GCSqGSIb3DQEB
BAUAA4GBAExH0StQaZ/phZAq9PXm8btBCaH3FQsH+P58+LZF/DYQRw/XL+a3ieI6O+YIgMrC
sQ+vtlCGqTdwvcKhjjgzMS/ialrV0e2COhxzVmccrhjYBvdF8Gzi/bcDxUKoXpSLQUMnMdc3
2Dtmo+t8EJmuK4U9qCWEFLbt7L1cLnQvFiM4MIID1jCCAz+gAwIBAgIEAgAB5jANBgkqhkiG
9w0BAQUFADBFMQswCQYDVQQGEwJVUzEYMBYGA1UEChMPR1RFIENvcnBvcmF0aW9uMRwwGgYD
VQQDExNHVEUgQ3liZXJUcnVzdCBSb290MB4XDTAxMDYwMTEyNDcwMFoXDTA0MDYwMTIzNTkw
MFowgZMxCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJDQTEWMBQGA1UEBxMNTW91bnRhaW4gVmll
dzEbMBkGA1UEChMSQW1lcmljYSBPbmxpbmUgSW5jMRkwFwYDVQQLExBBT0wgVGVjaG5vbG9n
aWVzMScwJQYDVQQDEx5JbnRyYW5ldCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkwgZ8wDQYJKoZI
hvcNAQEBBQADgY0AMIGJAoGBAOLvXyx2Q4lLGl+z5fiqb4svgU1n/71KD2MuxNyF9p4sSSYg
/wAX5IiIad79g1fgoxEZEarW3Lzvs9IVLlTGbny/2bnDRtMJBYTlU1xI7YSFmg47PRYHXPCz
eauaEKW8waTReEwG5WRB/AUlYybr7wzHblShjM5UV7YfktqyEkuNAgMBAAGjggGCMIIBfjBN
BgNVHR8ERjBEMEKgQKA+hjxodHRwOi8vd3d3MS51cy1ob3N0aW5nLmJhbHRpbW9yZS5jb20v
Y2dpLWJpbi9DUkwvR1RFUm9vdC5jZ2kwHQYDVR0OBBYEFCnbsi2Dfn+LI7vCzGa5Oegp8wKG
MGYGA1UdIARfMF0wRgYKKoZIhvhjAQIBBTA4MDYGCCsGAQUFBwIBFipodHRwOi8vd3d3LmJh
bHRpbW9yZS5jb20vQ1BTL09tbmlSb290Lmh0bWwwEwYDKgMEMAwwCgYIKwYBBQUHAgEwWAYD
VR0jBFEwT6FJpEcwRTELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD0dURSBDb3Jwb3JhdGlvbjEc
MBoGA1UEAxMTR1RFIEN5YmVyVHJ1c3QgUm9vdIICAaMwKwYDVR0QBCQwIoAPMjAwMTA2MDEx
MjQ3MzBagQ8yMDAzMDkwMTIzNTkwMFowDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwQIMAYBAf8C
AQEwDQYJKoZIhvcNAQEFBQADgYEASmIO2fpGdwQKbA3d/tIiOZkQCq6ILYY9V4TmEiQ3aftZ
XuIRsPmfpFeGimkfBmPRfe4zNkkQIA8flxcsJ2w9bDkEe+JF6IcbVLZgQW0drgXznfk6NJrj
e2tMcfjrqCuDsDWQTBloce3wYyJewlvsIHq1sFFz6QfugWd2eVP3ldQxggKmMIICogIBATCB
mjCBkzELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRYwFAYDVQQHEw1Nb3VudGFpbiBWaWV3
MRswGQYDVQQKExJBbWVyaWNhIE9ubGluZSBJbmMxGTAXBgNVBAsTEEFPTCBUZWNobm9sb2dp
ZXMxJzAlBgNVBAMTHkludHJhbmV0IENlcnRpZmljYXRlIEF1dGhvcml0eQICW+AwCQYFKw4D
AhoFAKCCAWEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDIx
MDE1MTgxNjIyWjAjBgkqhkiG9w0BCQQxFgQUO3ztkWTUIwaFcA1B9VMLlODHcTgwUgYJKoZI
hvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAw
BwYFKw4DAgcwDQYIKoZIhvcNAwICASgwga0GCyqGSIb3DQEJEAILMYGdoIGaMIGTMQswCQYD
VQQGEwJVUzELMAkGA1UECBMCQ0ExFjAUBgNVBAcTDU1vdW50YWluIFZpZXcxGzAZBgNVBAoT
EkFtZXJpY2EgT25saW5lIEluYzEZMBcGA1UECxMQQU9MIFRlY2hub2xvZ2llczEnMCUGA1UE
AxMeSW50cmFuZXQgQ2VydGlmaWNhdGUgQXV0aG9yaXR5AgJb3zANBgkqhkiG9w0BAQEFAASB
gErFDKB4/LWBVeNq7fDKxaJnlh7IOX+WSvZMJSwjcXjquEZ+Q3WwE+HRqvQhU2OUhBG7reFu
7v93Z9WcdQhWmyWdSAlTC/aOZZxlzyG7RyafP2klsC2DrQ+ujDUe/g2oYtXrBBFOCkbH9ksr
ICtBu2T1X8G5RyM+oePZj4CZNfgjAAAAAAAA
--------------ms010004000007090708020708--

