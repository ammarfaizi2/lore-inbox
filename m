Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290852AbSBNHuE>; Thu, 14 Feb 2002 02:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290869AbSBNHt4>; Thu, 14 Feb 2002 02:49:56 -0500
Received: from [208.179.59.195] ([208.179.59.195]:20860 "EHLO
	Booterz.killerlabs.com") by vger.kernel.org with ESMTP
	id <S290852AbSBNHtm>; Thu, 14 Feb 2002 02:49:42 -0500
Message-ID: <3C6B6C01.8000403@blue-labs.org>
Date: Thu, 14 Feb 2002 02:49:21 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020212
X-Accept-Language: en-us
MIME-Version: 1.0
To: Roberto Nibali <ratz@drugphish.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ver_linux script updates
In-Reply-To: <3C6ADCAA.6080600@blue-labs.org> <3C6B0DF8.10209@drugphish.ch> <3C6B144C.4020904@blue-labs.org> <3C6B20FD.1070601@drugphish.ch>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms060307000109090607000403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060307000109090607000403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

> Not in sh, you need an ugly 'awk|sed' call to do the printf with 
> formatstrings. And for the declare, you just drop it. Anyway, it is 
> incomplete. Or you can decide to do it in bash, and leave the nice 
> printf functionality and other gadgets. 


declare removed, printf can be a sh-util file as well as a bash built in 
so I'm not concerned with that.

> Well it does, but since this stupid loadkeys writes everything to 
> stderr you need to parse the output again as follows (on my machine):
>
> loadkeys --junkoption 2>&1 | head -2 | tail -1 

What is the full output of your loadkeys program with --junkoption?  I 
avoided using combinations of programs and chose to concentrate on 
implementing a one program only solution which was common through the 
script.

loadkeys is part of the kbd/console-tools mess.  It can report a 
version, not report a version, use --version or -V depending on what 
package or date in history your package comes from.

> This is so gross you could as well do a strings on all those broken 
> binaries and maintain a table of offsets where to find the version 
> string. 

Unfortunately this would evolve into a big pile of versions and offsets 
that nobody would want to touch with a 10' pole.

> Well, I could help you (not a bash guru either) but the more I think 
> about this the more I think it's like the attempt of ESR to make an 
> autoconfigurator. Let's see if I get this correctly:
>
> o I read ../Documentation/Changes and read that
>   "This document is designed to provide a list of the minimum levels of
>    software necessary to run the 2.4 kernels, ..."
>   Why the hell do I need pppd to get a running 2.4.x kernel? I also do
>   not need reiserfs tools because I decided to run ext3. Well and on my
>   firewall I definitely don't need any pcmcia-cs package which isn't
>   even completely merged into the main kernel. 

One doesn't, it's a generic list that makes some assumptions.  To this 
end, I've decided to add some /proc checking before searching for 
certain tool versions.

> o I ask myself: What exactly does this file want to tell people. I
>   might be dumb but to run a kernel you need to be able to compile it,
>   link it an install it (noone asks for lilo).
> o OTOH, the original author mentions that this software list should be
>   checked before one even considers a bug to be a real bug an not just
>   some incompatibility with a wrong user space tool. 

One of the most visible points in history is pppd, for a long while it 
seemed like the most frequently recurring bug post was why pppd didn't 
work. The version the bug reporter had was less than required.

> o I ask myself: How define the set of tools then? Shouldn't we for
>   example include LVM or raid tools (as actually mentioned further
>   down in the same file)?

I've just added checking to a few of the version searches that takes 
note from /proc files as to whether or not said support is loaded and 
running.  In other words it doesn't make to much sense to check for pppd 
if the user doesn't use pppd.  Note that this can certainly be 
misconstrued and I should put a --verbose, or perhaps trying to be smart 
here will just make matters worse.

> o Why is this script still in the kernel tree? It is not mentioned
>   anywhere and it doesn't work reliably. 

It is mentioned in the top level REPORTING-BUGS file.

> The whole concept looks pretty broken to me, but then again I'm just a 
> little fart that doesn't see the big picture. 

It helps to clean up  some ambiguities when a bug report comes in.

>> Because it doesn't work as well as I want it to.  The previous 
>> writers of this script wrote it based on their choice of distribution 
>> and installed packages.  There has always been one or more strange 
>> outputs or breakage when I run it .  All of my software is compiled 
>> from original tarballs or cvs from the original author.  That means 
>> if the 
>
>
> I have such a distro too, I might run your version of the script on it 
> as soon as I got some sleep.

I've updated it a few times since you've last retrieved it.

> What if it hangs like in my example? I suggest you switch over to perl 
> or if you want I can give you my bash-exec-alarm-signal handler I once 
> wrote. But it's an extreme overkill to have such a thing built-in in 
> your script. 

Personally I dislike perl ['s bubblegum fixes everything approach], I 
don't think it's worth it to make such a heavy requirement of a user. 
 The hang has been removed by adding the --junkoption, and as far as I 
know none of the given version checks should hang now.

> Good luck. I agree that certain information is important to have, such 
> as:
>
> o  Gnu C                  2.95.3                  # gcc --version
> o  Gnu make               3.77                    # make --version
> o  binutils               2.9.1.0.25              # ld -v
> o  util-linux             2.10o                   # fdformat --version
> o  modutils               2.4.2                   # insmod -V 


Actually, on four of my seven systems I don't have 'fdformat' so 
'util-linux' would have failed, but I -do- have 'mount' which is part of 
the same package.

> I fail to see why I need more information from that script. But don't 
> let yourself stop by my comments. 

Agreed, some people use less, some people more.

> I don't know how many tools I've already patched exactly because of 
> this bloody annoyance. If one wants to build a stable, reliable, 
> reproducable and secure box, where information can be get with simple 
> scripts without thousands of lines of code for every little funny 
> thing a programmer out there thought might be better than all other 
> existing tools. 


The only problem with patching tools like this, is that it often doesn't 
get back to the author or doesn't get implemented by the author, much 
less it doesn't fix earlier versions of the same software.

>> In a side note, if anybody has a reliable way of getting pppd to 
>> -always- report the version number, please tell me.  To get it to 
>> fail, put some junk in /etc/ppp/options, i.e. a not currently 
>> existing modem device such as /dev/usb/acm/0.
>
>
> Couldn't resist:
>
> laphish:~ # pppd
> (null): This system lacks kernel support for PPP.  This could be because
> the PPP kernel module could not be loaded, or because PPP was not
> included in the kernel configuration.  If PPP was included as a
> module, try `/sbin/modprobe -v ppp'.  If that fails, check t
> laphish:~ #
>
> Excellent output, isn't it? 

Ugg, don't get me started.  "pppd --version"  means I want the version. 
 I don't give a flying fsck whether the kernel supports it or not, and I 
don't give a flying fsck if I have a messed up options file.  I want the 
version, nothing more, nothing less. What's worse, there isn't a textual 
string for the version in the binary that I can grab.

David


--------------ms060307000109090607000403
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMDA4MzAwMDAwMDBaFw0wMjA4
MjkyMzU5NTlaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYD
VQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNhdGUg
U2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzAwgZ8w
DQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAN4zMqZjxwklRT7SbngnZ4HF2ogZgpcO40QpimM1
Km1wPPrcrvfudG8wvDOQf/k0caCjbZjxw0+iZdsN+kvx1t1hpfmFzVWaNRqdknWoJ67Ycvm6
AvbXsJHeHOmr4BgDqHxDQlBRh4M88Dm0m1SKE4f/s5udSWYALQmJ7JRr6aFpAgMBAAGjTjBM
MCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2YXRlTGFiZWwxLTI5NzASBgNVHRMBAf8E
CDAGAQH/AgEAMAsGA1UdDwQEAwIBBjANBgkqhkiG9w0BAQQFAAOBgQBzG28mZYv/FTRLWWKK
7US+ScfoDbuPuQ1qJipihB+4h2N0HG23zxpTkUvhzeY42e1Q9DpsNJKs5pKcbsEjAcIJp+9L
rnLdBmf1UG8uWLi2C8FQV7XsHNfvF7bViJu3ooga7TlbOX00/LaWGCVNavSdxcORL6mWuAU8
Uvzd6WIDSDGCAycwggMjAgEBMIGaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVy
biBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMU
Q2VydGlmaWNhdGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAy
MDAwLjguMzACAwZepDAJBgUrDgMCGgUAoIIBYTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0wMjAyMTQwNzQ5MjFaMCMGCSqGSIb3DQEJBDEWBBR3637fHRYg
d6cP1vdb4oxGKJsB+DBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMC
AgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBrQYLKoZIhvcN
AQkQAgsxgZ2ggZowgZIxCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQ
BgNVBAcTCUNhcGUgVG93bjEPMA0GA1UEChMGVGhhd3RlMR0wGwYDVQQLExRDZXJ0aWZpY2F0
ZSBTZXJ2aWNlczEoMCYGA1UEAxMfUGVyc29uYWwgRnJlZW1haWwgUlNBIDIwMDAuOC4zMAID
Bl6kMA0GCSqGSIb3DQEBAQUABIIBAJM86gy7YJDP0/YwWufRNFpyCNPGY55ZrMrLlJ693Phw
RMMkfdZNTXhLkTp5s64MBUfuomfNUseM84QeZkxH1+4dTZxVEPhNPCm8gP0BZ2pU4MLMs6+t
8rc3fTuiLtlgZEToUExiFfBO/vhnbsVVWI2MC5S5AzyCiGVDUAle3kiugUERzR4pta0oYTKi
ccSTwflEOJaoovmmC1aedm0jC4KI65yD+rxnTz2oG5LNXZzhaFM5C9USEyKnN+5lDDa6ZDEQ
BOgilxRDIxz7CUMR2CN8tOd1qCORn8fhiwOK4S4g2p5VXS/VzMpCwnCwHC22lijeTcFz1vON
hcITKwF6eREAAAAAAAA=
--------------ms060307000109090607000403--

