Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264627AbSJOUUK>; Tue, 15 Oct 2002 16:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264691AbSJOUUK>; Tue, 15 Oct 2002 16:20:10 -0400
Received: from mtao-m02.ehs.aol.com ([64.12.52.8]:56272 "EHLO
	mtao-m02.ehs.aol.com") by vger.kernel.org with ESMTP
	id <S264627AbSJOUUH>; Tue, 15 Oct 2002 16:20:07 -0400
Date: Tue, 15 Oct 2002 13:25:55 -0700
From: John Gardiner Myers <jgmyers@netscape.com>
Subject: Re: [PATCH] async poll for 2.5
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Dan Kegel <dank@kegel.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Message-id: <3DAC79D3.2010908@netscape.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------ms070603050303010500060801; micalg=sha1;
 protocol="application/x-pkcs7-signature"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2a)
 Gecko/20020910
References: <3DAB46FD.9010405@watson.ibm.com>
 <20021015110501.B11395@redhat.com> <3DAC4B0E.EBB3A2AB@kegel.com>
 <3DAC59ED.2070405@watson.ibm.com> <3DAC643C.86A016B4@kegel.com>
 <20021015145731.J14596@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms070603050303010500060801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin LaHaise wrote:

>If you look at how /dev/epoll does it, the collapsing of readiness 
>events is very elegant: a given fd is only allowed to report a change 
>in its state once per run through the event loop.
>
And the way /dev/epoll does it has a key flaw: it only works with single 
threaded callers.  If you have multiple threads simultaneously trying to 
get events, then race conditions abound.

>The ioctl that swaps 
>event buffers acts as a barrier between the two possible reports.
>
Which assumes there are only single threaded callers.  To work correctly 
with multithreaded callers, there needs to be a more explicit mechanism 
for a caller to indicate it has completed handling an event and wants to 
rearm its interest.

There are also additional interactions with cancellation.  How does the 
cancellation interface report and handle the case where an associated 
event is being delivered or handled by another thread?  What happens 
when that thread then tries to rearm the canceled interest?

I certainly hope /dev/epoll itself doesn't get accepted into the kernel, 
the interface is error prone.  Registering interest in a condition when 
the condition is already true should immediately generate an event, the 
epoll interface did not do that last time I saw it discussed.  This 
deficiency in the interface requires callers to include more complex 
workaround code and is likely to result in subtle, hard to diagnose bugs.


--------------ms070603050303010500060801
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
MDE1MjAyNTU1WjAjBgkqhkiG9w0BCQQxFgQUgDu9NfyycneNldjh/GVhfQlZimkwUgYJKoZI
hvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAw
BwYFKw4DAgcwDQYIKoZIhvcNAwICASgwga0GCyqGSIb3DQEJEAILMYGdoIGaMIGTMQswCQYD
VQQGEwJVUzELMAkGA1UECBMCQ0ExFjAUBgNVBAcTDU1vdW50YWluIFZpZXcxGzAZBgNVBAoT
EkFtZXJpY2EgT25saW5lIEluYzEZMBcGA1UECxMQQU9MIFRlY2hub2xvZ2llczEnMCUGA1UE
AxMeSW50cmFuZXQgQ2VydGlmaWNhdGUgQXV0aG9yaXR5AgJb3zANBgkqhkiG9w0BAQEFAASB
gApiN7rcLhsv9S2hHgglX1dR06vDe/3kq7jaU04T+deyyCZI77tO1M9MxlVIQUe5mO7x0KqS
hg8AS8lOU9MxsTqsnatWM7VnQ5PW7Q6H6SVyn0cSO4zwccujRY51ZAQfBiYOIkVj2aik0f6G
nLSppg+xz1uC0MEjmXumlJZhYV+UAAAAAAAA
--------------ms070603050303010500060801--

