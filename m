Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161264AbWJLB66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161264AbWJLB66 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 21:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161344AbWJLB66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 21:58:58 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:21362 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1161264AbWJLB65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 21:58:57 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FACg9LUWBSokogTI
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.128.19):SA:0(-1.3/5.0):. Processed in 3.008387 secs Process 8697)
Subject: [PATCH] take #1 report_lost_ticks boot parameter should be default
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-OuGfhqEwxoYelpMhJylk"
Date: Thu, 12 Oct 2006 02:58:49 +0100
Message-Id: <1160618330.8766.24.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
X-OriginalArrivalTime: 12 Oct 2006 01:58:55.0543 (UTC) FILETIME=[F957B470:01C6EDA1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OuGfhqEwxoYelpMhJylk
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,
After begin testing next patches for 2.4.19. =20
I tried the 2.6.18-mm3 and I tried boot up with acpi=3Dnoirq (which is the
same of pci=3Dnoacpi), and boots fine without any warning.
And it was a nightmare on stress testings of this two days. At begging I
don't understand why, but after a while I try remember report_lost_ticks
and nightmare ends. The boot parameter reports lost ticket everywhere,
because I (still) need boot up with "notsc".
I believe that it not just my computer that suffer this problem and with
report_lost_ticks by default, we understand quickly that we need boot
with "notsc" or something else. For computer don't crash on a little
stress. Like play a avi movie with mplyer and copy over Ethernet some
others files.
=20
Something like this :=20
diff ./x86_64/kernel/time.c.orig ./x86_64/kernel/time.c -up
--- ./x86_64/kernel/time.c.orig 2006-10-12 02:50:41.000000000 +0100
+++ ./x86_64/kernel/time.c      2006-10-12 02:54:52.000000000 +0100
@@ -71,7 +71,7 @@ static unsigned long hpet_period;                     /* =
f
 unsigned long hpet_tick;                               /* HPET clocks / in=
terrupt */
 int hpet_use_timer;                            /* Use counter of hpet for =
time keeping, otherwise PIT */
 unsigned long vxtime_hz =3D PIT_TICK_RATE;
-int report_lost_ticks;                         /* command line option */
+int noreport_lost_ticks;                               /* command line opt=
ion */
 unsigned long long monotonic_base;

 struct vxtime_data __vxtime __section_vxtime;  /* for vsyscalls */
@@ -316,7 +316,7 @@ static noinline void handle_lost_ticks(i
 {
        static long lost_count;
        static int warned;
-       if (report_lost_ticks) {
+       if (!noreport_lost_ticks) {
                printk(KERN_WARNING "time.c: Lost %d timer tick(s)! ", lost=
);
                print_symbol("rip %s)\n", regs->rip);
        }
@@ -885,7 +885,7 @@ void __init stop_timer_interrupt(void)

 int __init time_setup(char *str)
 {
-       report_lost_ticks =3D 1;
+       noreport_lost_ticks =3D 1;
        return 1;
 }

@@ -1004,7 +1004,7 @@ __init static char *time_init_gtod(void)
        return timetype;
 }

-__setup("report_lost_ticks", time_setup);
+__setup("noreport_lost_ticks", time_setup);

 static long clock_cmos_diff;
 static unsigned long sleep_start;

Thanks,
--=20
S=E9rgio M.B.

--=-OuGfhqEwxoYelpMhJylk
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
SIb3DQEJBTEPFw0wNjEwMTIwMTU4NDlaMCMGCSqGSIb3DQEJBDEWBBSo1ZEBPncifq/1znmPixVw
18SU4TANBgkqhkiG9w0BAQEFAASCAQAZNSqV1MPLOSikvC0ptRXBcCNlnXCLIEjfeMbVUhG6xcmp
5Qi8/1U2f8+2yZkBVzaY+O4YwAhoJEV3A3Qr/2nznL35G5GKP6iKKTappCnobtFhtdW/+hN7s/lj
ogemKZnEx6vDpqCrcrzWRr5rC2+G78RIKH+IgZ5TOAwsi+R2qqjIyVsobPJav7fzhhOSEi89Ut5X
g6GB9g85K+tKbDjWVTm7VWbXgljMlMNWNBxoNexQXHAP+CBz2IvMz0oiGwaH0P5uWnI8NRFHerGH
CYI36E2Kp5GhFksoh3O377FL0EW6XZcVzmbCt8oOlqx+2t7K/uFX5qQJYNTyb9ocT4uvAAAAAAAA



--=-OuGfhqEwxoYelpMhJylk--
