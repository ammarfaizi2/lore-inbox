Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVKJJh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVKJJh1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 04:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVKJJh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 04:37:27 -0500
Received: from baldrick.bootc.net ([83.142.228.48]:32394 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1750724AbVKJJh0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 04:37:26 -0500
In-Reply-To: <17266.56637.123797.468396@cse.unsw.edu.au>
References: <4371FA5B.6030900@bootc.net> <17266.30440.930561.902428@cse.unsw.edu.au> <3356B173-1C22-4C46-8CC4-1A08C303C63D@bootc.net> <17266.56637.123797.468396@cse.unsw.edu.au>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: multipart/signed; micalg=sha1; boundary=Apple-Mail-1-836902539; protocol="application/pkcs7-signature"
Message-Id: <45372A5E-E75A-48F0-982B-A47DCA1B83D4@bootc.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
From: Chris Boot <bootc@bootc.net>
Subject: Re: 2.6.14-mm1 RAID-1 in D< state
Date: Thu, 10 Nov 2005 09:37:21 +0000
To: Neil Brown <neilb@suse.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-1-836902539
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

On 10 Nov 2005, at 5:40, Neil Brown wrote:

>
> Thanks for the trace.  I see what is happening.
> I changed
>   wait_event_timeout_interruptible
> in md.c(md_thread) to
>   wait_event_timeout
>
> as the thread no longer needs to be able to respond the signals.
> However that has the side-effect of putting the process in the 'D'
> state and adding to the 'uptime'.
>
> I guess I'll put that back...
>
> NeilBrown
>
>
> Signed-off-by: Neil Brown <neilb@suse.de>
>
> ### Diffstat output
>  ./drivers/md/md.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff ./drivers/md/md.c~current~ ./drivers/md/md.c
> --- ./drivers/md/md.c~current~	2005-11-10 16:39:04.000000000 +1100
> +++ ./drivers/md/md.c	2005-11-10 16:39:28.000000000 +1100
> @@ -3439,10 +3439,11 @@ static int md_thread(void * arg)
>  	allow_signal(SIGKILL);
>  	while (!kthread_should_stop()) {
>
> -		wait_event_timeout(thread->wqueue,
> -				   test_bit(THREAD_WAKEUP, &thread->flags)
> -				   || kthread_should_stop(),
> -				   thread->timeout);
> +		wait_event_timeout_interruptible
> +			(thread->wqueue,
> +			 test_bit(THREAD_WAKEUP, &thread->flags)
> +			 || kthread_should_stop(),
> +			 thread->timeout);
>  		try_to_freeze();
>
>  		clear_bit(THREAD_WAKEUP, &thread->flags);

Sounds about right but...

drivers/md/md.c: In function `md_thread':
drivers/md/md.c:3441: warning: implicit declaration of function  
`wait_event_timeout_interruptible'
[...]
   LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x9904f): In function `md_thread':
: undefined reference to `wait_event_timeout_interruptible'
drivers/built-in.o(.text+0x9908f): In function `md_thread':
: undefined reference to `wait_event_timeout_interruptible'
make: *** [.tmp_vmlinux1] Error 1

HTH,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/



--Apple-Mail-1-836902539
Content-Transfer-Encoding: base64
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Disposition: attachment;
	filename=smime.p7s

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGEjCCAssw
ggI0oAMCAQICAw4IwzANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUwMjE0MjEyNjMzWhcNMDYwMjE0MjEyNjMzWjBBMR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMR4wHAYJKoZIhvcNAQkBFg9ib290Y0Bib290Yy5uZXQw
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC6aATCjyi9z5A42up8tmL1D0gc/TvBsCIJ
ehXpdQJ1gGC5d6MlKLpQIF8zVzOjwOkFO7hluPVVAzrSo5/jvcSCl2SYj0OMiBS3BZh7JBMb6Ld+
+I5zrKnQFA4OCtBfaDS4xpErhjCgxYo4uk0HCJyI9T/foELKVJba4iRdnmggI513ifG8eIV94y+Z
rSVgejMisnLOM9xg0LfWwJZmbnYcszvkGKmAWzzqGfZFig2AR8I/NnVqYwr42JDlFMNKsz0kNdeq
ED29yI8IGITfzk3Xc5eMfm2PPEs1drf6vfR38GBLYL8UkgAbtTBiRvte4jS+aA6kKyvN0gIDq2+S
r06HAgMBAAGjLDAqMBoGA1UdEQQTMBGBD2Jvb3RjQGJvb3RjLm5ldDAMBgNVHRMBAf8EAjAAMA0G
CSqGSIb3DQEBBAUAA4GBAID0mAm4oxd1eY6KoCmdoTGfkeaYBnP+vd00juiKXwlYfZ1/TPMCbIeD
KHINuQbIUVH3u+vga56aaiwj31EG6D/7O8GePQPDo4HSgbo6cfGM21ELowr2e/qUg1EyoWwhATak
QDYLSBEIdAsQJnUwV32LZA/PFYGu0S5i25u7d4FpMIIDPzCCAqigAwIBAgIBDTANBgkqhkiG9w0B
AQUFADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2Fw
ZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEoMCYGA1UECxMfQ2VydGlmaWNhdGlv
biBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIENB
MSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVlbWFpbEB0aGF3dGUuY29tMB4XDTAzMDcxNzAw
MDAwMFoXDTEzMDcxNjIzNTk1OVowYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25z
dWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1
aW5nIENBMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/
ox7svc31W/Iadr1/DDph8r9RzgHU5VAKMNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoT
zyvV84J3PQO+K/67GD4Hv0CAAmTXp6a7n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GU
MIGRMBIGA1UdEwEB/wQIMAYBAf8CAQAwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3
dGUuY29tL1RoYXd0ZVBlcnNvbmFsRnJlZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQi
MCCkHjAcMRowGAYDVQQDExFQcml2YXRlTGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQ
g+oLLswNo2asZw9/r6y+whehQ5aUnX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsA
xRoLgnSeJVCUYsfbJ3FXJY3dqZw5jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXe
JLHTHUb/XV9lTzGCAucwggLjAgEBMGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBD
b25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJ
c3N1aW5nIENBAgMOCMMwCQYFKw4DAhoFAKCCAVMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAc
BgkqhkiG9w0BCQUxDxcNMDUxMTEwMDkzNzIxWjAjBgkqhkiG9w0BCQQxFgQUofQkS9OB2+Awa+mX
IDdGGOaAZiQweAYJKwYBBAGCNxAEMWswaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3Rl
IENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWls
IElzc3VpbmcgQ0ECAw4IwzB6BgsqhkiG9w0BCRACCzFroGkwYjELMAkGA1UEBhMCWkExJTAjBgNV
BAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25h
bCBGcmVlbWFpbCBJc3N1aW5nIENBAgMOCMMwDQYJKoZIhvcNAQEBBQAEggEANgJ6imfMC2RZ+n3m
la51/gcH+fYgBIEyTj89+4FwFB7zwJb5o8JBTDgPYyTrMtbm9b63fibO7Y1b03LgW7OFna+/+3fW
pFyPYuRjRMPuEkUEQpRZxW+SYh+prDod/gaTjANwolApT0XESiv3/pYbyTdcXIa6R2vUFYBpup/y
AvusuUUqXYh/cDq+Ll1Oqjmy+OoASTFmN+2gC6civlkKqpDbAvoq4+EHHa9Bh1+FxqWF7oIDTup2
WnIMygqLGKTZza90/X3JLz7KLjAFgXk2mnMpuhTlkfSuugAXSIg9JMUDU77OFWByeSI7ujdXIedA
6xxWtCEQo/Sj6c5C0El2hQAAAAAAAA==

--Apple-Mail-1-836902539--
