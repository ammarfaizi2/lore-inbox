Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWJWUd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWJWUd3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbWJWUd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:33:29 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:21726 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1750719AbWJWUd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:33:27 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CACbDPEVThFhodGdsb2JhbACBTIkkgTI
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.129.202):SA:0(0.6/5.0):. Processed in 4.113106 secs Process 17422)
Subject: Re: 2.6.18-rt6 and compile fail with rt7 on x86_64
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: john stultz <johnstul@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Mike Galbraith <efault@gmx.de>,
       Daniel Walker <dwalker@mvista.com>,
       Manish Lachwani <mlachwani@mvista.com>, bastien.dugue@bull.net,
       Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <1161305999.6961.142.camel@localhost>
References: <20061018083921.GA10993@elte.hu>
	 <1161303812.3020.15.camel@localhost.portugal>
	 <1161305999.6961.142.camel@localhost>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-pjPgORUnoiLiGRlFxiHH"
Date: Mon, 23 Oct 2006 21:33:15 +0100
Message-Id: <1161635595.2948.19.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
X-OriginalArrivalTime: 23 Oct 2006 20:33:26.0066 (UTC) FILETIME=[7DD30120:01C6F6E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pjPgORUnoiLiGRlFxiHH
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-10-19 at 17:59 -0700, john stultz wrote:
> On Fri, 2006-10-20 at 01:23 +0100, Sergio Monteiro Basto wrote:
> > I just test rt6 it in my problematic VIA Board with one PENTIUM D (DUAL=
)
> >=20
> > 1. don't apply cleaning to 2.16.18.1 (on sparc arch )
> > 2. I usual boot with notsc (because without it give me many lost time
> > tickets)
> >     I try 2.16.18.1-rt6 without notsc and freeze on boot.=20
> >     I try with notsc and says=20
> >         Time: acpi_pm clocksource has been installed.
> >         Looks stable and don't show any lost timer ticket on dmesg.
>=20
> Out of curiosity, does 2.6.18.1 require notsc (or booting w/
> clocksource=3Dacpi_pm) to be stable? Or is it just -rt6 that has this
> problem?
>=20

yes, 2.6.18.1 require notsc to work properly , but without notsc boots
normally but with  many lost timer ticks=20
    time.c: Lost 300 timer tick(s)! rip mwait_idle+0x3f/0x54)
    psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost
synchronization, throwing 2 bytes away.
    time.c: Lost 300 timer tick(s)! rip mwait_idle+0x3f/0x54)

booting with clocksource=3Dacpi_pm , don't find/use   acpi_pm
cat /sys/devices/system/clocksource/clocksource0/available_clocksource
jiffies

> > But I want also work with Nvidia dri which is a close drive from NVIDIA=
.
> > I install that drive and I enable DRI, After a few minutes I got a
> > spontaneous reboot.
> > I will keep testing without nvidia close source.
> >=20
> > And I like to know if this rt6 patch make this new clocksource (acpi_pm=
)
> > or just found it and use it ?=20
>=20
> -rt6 includes a patch from Thomas Gleixner that disables the TSC if
> dynticks are enabled in your config.

I will try that=20

Thanks,=20
>=20
> thanks
> -john
>=20

compiles fails with rt7=20
+ KernelImage=3Darch/x86_64/boot/bzImage
+ make -s ARCH=3Dx86_64 oldconfig
+ make -s ARCH=3Dx86_64 -j2 bzImage
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  CHK     include/linux/utsrelease.h
  SYMLINK include/asm -> include/asm-x86_64
  UPD     include/linux/utsrelease.h
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
kernel/rtmutex.c:938:48: error: macro "rt_release_bkl" passed 2
arguments, but takes just 1
kernel/rtmutex.c: In function 'rt_mutex_slowlock':
kernel/rtmutex.c:938: error: 'rt_release_bkl' undeclared (first use in
this function)
kernel/rtmutex.c:938: error: (Each undeclared identifier is reported
only once
kernel/rtmutex.c:938: error: for each function it appears in.)
make[1]: *** [kernel/rtmutex.o] Error 1
make: *** [kernel] Error 2


thanks=20
--=20
S=E9rgio M.B.

--=-pjPgORUnoiLiGRlFxiHH
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGSTCCAwIw
ggJroAMCAQICAw/vkjANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUxMTI4MjIyODU2WhcNMDYxMTI4MjIyODU2WjBLMR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSgwJgYJKoZIhvcNAQkBFhlzZXJnaW9Ac2VyZ2lvbWIu
bm8taXAub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApCNuKD3pz8GRKd1q+36r
m0z7z+TBsbTrVa45UQsEeh9OQGZIASJMH5erC0u6KbKJ+km97RLOdsgSlKG6+5xuzsk+aqU7A0Gp
kMjzIJT7UH/bbPnIFMQNnWJxluuYq1u+v8iIbfezQy1+SXyAyBv+OC7LnCOiOar/L9AD9zDy2fPX
EqEDlbO3CJsoaR4Va8sgtoV0NmKnAt7DA0iZ2dmlsw6Qh+4euI+FgZ2WHPBQnfJ7PfSH5GIWl/Nx
eUqnYpDaJafk/l94nX71UifdPXDMxJJlEOGqV9l4omhNlPmsZ/zrGXgLdBv9JuPjJ9mxhgwZsZbz
VBc8emB0i3A7E6D6rwIDAQABo1kwVzAOBgNVHQ8BAf8EBAMCBJAwEQYJYIZIAYb4QgEBBAQDAgUg
MCQGA1UdEQQdMBuBGXNlcmdpb0BzZXJnaW9tYi5uby1pcC5vcmcwDAYDVR0TAQH/BAIwADANBgkq
hkiG9w0BAQQFAAOBgQBIVheRn3oHTU5rgIFHcBRxkIhOYPQHKk/oX4KakCrDCxp33XAqTG3aIG/v
dsUT/OuFm5w0GlrUTrPaKYYxxfQ00+3d8y87aX22sUdj8oXJRYiPgQiE6lqu9no8axH6UXCCbKTi
8383JcxReoXyuP000eUggq3tWr6fE/QmONUARzCCAz8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEF
BQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUg
VG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24g
U2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTEr
MCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAw
MDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3Vs
dGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me
7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r
1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCB
kTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhhd3Rl
LmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNVHREEIjAg
pB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQADgYEASIzRUIPq
Cy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUa
C4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpbNU1341YheILcIRk13iSx
0x1G/11fZU8xggHvMIIB6wIBATBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNz
dWluZyBDQQIDD++SMAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0wNjEwMjMyMDMzMTVaMCMGCSqGSIb3DQEJBDEWBBSnAAPa/xuHJsmHW2rEF62M
9CgiADANBgkqhkiG9w0BAQEFAASCAQCJUCZFeVbcDqLaOktbTlvs2neIC0XLVPPVZGQ+iJPIxfqj
juLccr+XcadqgJNqWC6PiovSEkuM4b8ImURHz5pU1w5LrU7ryDDLYlB/B3bUu4GgkR16OFYQvJc/
fuW1fsnldrB4Ul0v0hgQ7AWiQwisAxs0m9izrtEt4C6qSni3lKDg8W/HysfVPa83uflJLDjpTiQO
svj+5G4GGG4WvVCjf2s/ZVmhZxoT025o/I+bgThLemWYnhErk57ro148kcXP+cdnVxx+cJX0W+et
/oZleW5x1asg0FU6kkyIXvpEJAVoTIdjZoWVFYVoGEtzGeBtSoANOqS9JZArtz7FJkK1AAAAAAAA



--=-pjPgORUnoiLiGRlFxiHH--
