Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129053AbQJ3Up0>; Mon, 30 Oct 2000 15:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129079AbQJ3UpH>; Mon, 30 Oct 2000 15:45:07 -0500
Received: from h-205-217-237-46.netscape.com ([205.217.237.46]:31195 "EHLO
	netscape.com") by vger.kernel.org with ESMTP id <S129053AbQJ3Uoz>;
	Mon, 30 Oct 2000 15:44:55 -0500
Date: Mon, 30 Oct 2000 12:44:09 -0800
From: John Gardiner Myers <jgmyers@netscape.com>
Subject: Re: Readiness vs. completion (was: Re: Linux's
 implementationofpoll()not scalable?)
To: dank@alumni.caltech.edu
Cc: linux-kernel@vger.kernel.org
Message-id: <39FDDD99.BD1889BB@netscape.com>
MIME-version: 1.0
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
Content-type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=sha1; boundary=------------ms9FD2EB51B171FF1908566527
X-Accept-Language: en
In-Reply-To: <39FCC2B8.DA281B4C@alumni.caltech.edu>
 <39FDC42A.CD9C3D12@netscape.com> <39FDC97C.456478E1@alumni.caltech.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms9FD2EB51B171FF1908566527
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



Dan Kegel wrote:
> If you have a top-notch completion notification event interface
> provided natively by the OS, though, does that get rid of the
> need for the "async poll" mechanism?

A top-notch completion notification event interface needs to be able to
provide "async poll" functionality.  There are some situations where an
application needs a completion notification event when an fd is readable
or writeable, but cannot supply buffers or data until after the event
arrives.

One of these situations is when the application is using a nonblocking
interface to an existing library.  When the library returns a
"wouldblock" condition, the application determines through the interface
(or the interface definition) which poll events need to occur before a
subsequent call to the library is likely to result in progress.  The
application then needs to schedule a completion event for when those
poll events occur.  The application does not know enough about the
library implementation to schedule async I/O and the library is not
written to use async I/O itself.

Another situation occurs when handling a large number of mostly idle
connections.  Consider a protocol for which a server receives one
command per half hour per connection.  A server process would want to
handle hundreds of thousands to millions of such connections.  If the
server were to use asynchronous read operations, then it would have to
allocate one input buffer per connection.  Better to instead use
asynchronous read poll operations, allocating buffers to connections
only when those connections have pending input.

This latter situation would be further improved by a variant of the
asynchronous read operation where the buffer is supplied by either the
event queue object or the caller to get_event(), but that's a separate
issue.
--------------ms9FD2EB51B171FF1908566527
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIIXwYJKoZIhvcNAQcCoIIIUDCCCEwCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCC
BlkwggMMMIICdaADAgECAgIeFDANBgkqhkiG9w0BAQQFADCBkzELMAkGA1UEBhMCVVMxCzAJ
BgNVBAgTAkNBMRYwFAYDVQQHEw1Nb3VudGFpbiBWaWV3MRswGQYDVQQKExJBbWVyaWNhIE9u
bGluZSBJbmMxGTAXBgNVBAsTEEFPTCBUZWNobm9sb2dpZXMxJzAlBgNVBAMTHkludHJhbmV0
IENlcnRpZmljYXRlIEF1dGhvcml0eTAeFw0wMDA2MDIxNzE1MjlaFw0wMDExMjkxNzE1Mjla
MIGCMRMwEQYKCZImiZPyLGQBGRYDY29tMRgwFgYKCZImiZPyLGQBGRYIbmV0c2NhcGUxIzAh
BgkqhkiG9w0BCQEWFGpnbXllcnNAbmV0c2NhcGUuY29tMRMwEQYDVQQDEwpKb2huIE15ZXJz
MRcwFQYKCZImiZPyLGQBARMHamdteWVyczCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEA
0+WYWlf3g+u6vFEBJwo+4Cxz0PM5GUuqOHGVkjPFTeGjR05BUJADWm8mZDoAhUuIVuTvixCx
AB0f5JzDWmIIWbB0ea92RwOHdibSS3bT0BTwKNTgt+PQAH3ZdH+IjmGAZI6/J+5Ob3m43ZZl
o/3lfGEd4O7gAJY62Sy76MgO1O0CAwEAAaN+MHwwEQYJYIZIAYb4QgEBBAQDAgWgMA4GA1Ud
DwEB/wQEAwIEsDAfBgNVHSMEGDAWgBSiO2Uy9/cbifxVDQcBvIdIWv2QPTA2BggrBgEFBQcB
AQQqMCgwJgYIKwYBBQUHMAGGGmh0dHA6Ly9uc29jc3AubmV0c2NhcGUuY29tMA0GCSqGSIb3
DQEBBAUAA4GBAGPAOC3FZineuE0PLv+pKc52i5uz+lpHzvssmUrr5FNSSD3M+DBow7Sd3YW+
vyPVAxH+MZ5RtE+If/aDDYQhgpCtbujQb5wPVRS5ZCmKpAC0eOnP12jcUDLr1tfhyBIlIvJQ
6xGKj7ckSK6G7lNxuQ8a12v/v2yEEk2uADg51oY7MIIDRTCCAq6gAwIBAgIBJzANBgkqhkiG
9w0BAQQFADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UE
BxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEoMCYGA1UECxMfQ2Vy
dGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhhd3RlIFBlcnNvbmFs
IEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVlbWFpbEB0aGF3dGUu
Y29tMB4XDTk5MDYwMzIyMDAzNFoXDTAxMDYwMjIyMDAzNFowgZMxCzAJBgNVBAYTAlVTMQsw
CQYDVQQIEwJDQTEWMBQGA1UEBxMNTW91bnRhaW4gVmlldzEbMBkGA1UEChMSQW1lcmljYSBP
bmxpbmUgSW5jMRkwFwYDVQQLExBBT0wgVGVjaG5vbG9naWVzMScwJQYDVQQDEx5JbnRyYW5l
dCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAOLv
Xyx2Q4lLGl+z5fiqb4svgU1n/71KD2MuxNyF9p4sSSYg/wAX5IiIad79g1fgoxEZEarW3Lzv
s9IVLlTGbny/2bnDRtMJBYTlU1xI7YSFmg47PRYHXPCzeauaEKW8waTReEwG5WRB/AUlYybr
7wzHblShjM5UV7YfktqyEkuNAgMBAAGjaTBnMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0l
BBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMBEGCWCGSAGG+EIBAQQEAwIBAjAfBgNVHSMEGDAW
gBRyScJzNMZV9At2coF+d/SH58ayDjANBgkqhkiG9w0BAQQFAAOBgQC6UH38ALL/QbQHCDkM
IfRZSRcIzI7TzwxW8W/oCxppYusGgltprB2EJwY5yQ5+NRPQfsCPnFh8AzEshxDVYjtw1Q6x
ZIA0Tln6xlnmRt5OaAh1QPUdjCnWrnetyT1p5ECNRJdGb756wFiksR9qpw8pUYqBDSmOneQP
MwuPjSQ97DGCAc4wggHKAgEBMIGaMIGTMQswCQYDVQQGEwJVUzELMAkGA1UECBMCQ0ExFjAU
BgNVBAcTDU1vdW50YWluIFZpZXcxGzAZBgNVBAoTEkFtZXJpY2EgT25saW5lIEluYzEZMBcG
A1UECxMQQU9MIFRlY2hub2xvZ2llczEnMCUGA1UEAxMeSW50cmFuZXQgQ2VydGlmaWNhdGUg
QXV0aG9yaXR5AgIeFDAJBgUrDgMCGgUAoIGKMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTAwMTAzMDIwNDQwOVowIwYJKoZIhvcNAQkEMRYEFB4g9q0f8krH
JDULtjO7fDkjxcmKMCsGCSqGSIb3DQEJDzEeMBwwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwIC
AgCAMA0GCSqGSIb3DQEBAQUABIGATihthZYhzNReAB7k7eSGisdL5IxJJcAXGEy3cufhfcMm
/GWcyznVR1Kwxkts2jAMkE6/yeSSjBcFH5Ojy1e0zFSIikRP0NkvlEi3drYatYbPmeMImD91
a+ItMcCUykA95IJ9PoPvw0XTjIEmxvMB7hdXTvZTs1XuIgYSXYm43So=
--------------ms9FD2EB51B171FF1908566527--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
