Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131318AbRCWRst>; Fri, 23 Mar 2001 12:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131296AbRCWRsk>; Fri, 23 Mar 2001 12:48:40 -0500
Received: from 152.145.126.209.reverse.cari.net ([209.126.145.154]:17939 "EHLO
	newportharbornet.com") by vger.kernel.org with ESMTP
	id <S131318AbRCWRs3>; Fri, 23 Mar 2001 12:48:29 -0500
Date: Fri, 23 Mar 2001 09:49:47 -0800 (PST)
From: Bob Lorenzini <hwm@newportharbornet.com>
To: linux-kernel@vger.kernel.org
Subject: Linux Worm (fwd)
Message-ID: <Pine.LNX.4.21.0103230947250.14872-100000@newportharbornet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm annoyed when persons post virus alerts to unrelated lists but this
is a serious threat. If your offended flame away.

Bob


March 23, 2001 7:00 AM

Late last night, the SANS Institute (through its Global Incident
Analysis Center) uncovered a dangerous new worm that appears to be
spreading rapidly across the Internet.  It scans the Internet looking
for Linux computers with a known vulnerability. It infects the
vulnerable machines, steals the password file  (sending it to a
China.com site), installs other hacking tools, and forces the newly
infected machine to begin scanning the Internet looking for other
victims.

Several experts from the security community worked through the night to
decompose the worm's code and engineer a utility to help you discover
if the Lion worm has affected your organization.

Updates to this announcement will be posted at the SANS web site,
http://www.sans.org


DESCRIPTION

The Lion worm is similar to the Ramen worm. However, this worm is
significantly more dangerous and should be taken very seriously.  It
infects Linux machines running the BIND DNS server.  It is known to
infect bind version(s) 8.2, 8.2-P1, 8.2.1, 8.2.2-Px, and all
8.2.3-betas. The specific vulnerability used by the worm to exploit
machines is the TSIG vulnerability that was reported on January 29,
2001.

The Lion worm spreads via an application called "randb".  Randb scans
random class B networks probing TCP port 53. Once it hits a system, it
checks to see if it is vulnerable. If so, Lion exploits the system using
an exploit called "name".  It then installs the t0rn rootkit.

Once Lion has compromised a system, it:

- Sends the contents of /etc/passwd, /etc/shadow, as well as some
network settings to an address in the china.com domain.
- Deletes /etc/hosts.deny, eliminating the host-based perimeter
protection afforded by tcp wrappers.
- Installs backdoor root shells on ports 60008/tcp and 33567/tcp (via
inetd, see /etc/inetd.conf)
- Installs a trojaned version of ssh that listens on 33568/tcp
- Kills Syslogd , so the logging on the system can't be trusted
- Installs a trojaned version of login
- Looks for a hashed password in /etc/ttyhash
- /usr/sbin/nscd (the optional Name Service Caching daemon) is
overwritten with a trojaned version of ssh.

The t0rn rootkit replaces several binaries on the system in order to
stealth itself. Here are the binaries that it replaces:

du, find, ifconfig, in.telnetd, in.fingerd, login, ls, mjy, netstat,
ps, pstree, top

- "Mjy" is a utility for cleaning out log entries, and is placed in /bin
and /usr/man/man1/man1/lib/.lib/.
- in.telnetd is also placed in these directories; its use is not known
at this time.
- A setuid shell is placed in /usr/man/man1/man1/lib/.lib/.x

DETECTION AND REMOVAL

We have developed a utility called Lionfind that will detect the Lion
files on an infected system.  Simply download it, uncompress it, and
run lionfind.  This utility will list which of the suspect files is on
the system.

At this time, Lionfind is not able to remove the virus from the system.
If and when an updated version becomes available (and we expect to
provide one), an announcement will be made at this site.

Download Lionfind at http://www.sans.org/y2k/lionfind-0.1.tar.gz


REFERENCES

Further information can be found at:

http://www.sans.org/current.htm
http://www.cert.org/advisories/CA-2001-02.html, CERT Advisory CA-2001-02,
Multiple Vulnerabilities in BIND
http://www.kb.cert.org/vuls/id/196945 ISC BIND 8 contains buffer overflow
in transaction signature (TSIG) handling code
http://www.sans.org/y2k/t0rn.htm Information about the t0rn rootkit.
The following vendor update pages may help you in fixing the original BIND
vulnerability:

Redhat Linux RHSA-2001:007-03 - Bind remote exploit
http://www.redhat.com/support/errata/RHSA-2001-007.html
Debian GNU/Linux DSA-026-1 BIND
http://www.debian.org/security/2001/dsa-026
SuSE Linux SuSE-SA:2001:03 - Bind 8 remote root compromise.
http://www.suse.com/de/support/security/2001_003_bind8_ txt.txt
Caldera Linux CSSA-2001-008.0 Bind buffer overflow
http://www.caldera.com/support/security/advisories/CSSA-2001-008.0.txt
http://www.caldera.com/support/security/advisories/CSSA-2001-008.1.txt

This security advisory was prepared by Matt Fearnow of the SANS
Institute and William Stearns of the Dartmouth Institute for Security
Technology Studies.

The Lionfind utility was written by William Stearns. William is an
Open-Source developer, enthusiast, and advocate from Vermont, USA. His
day job at the Institute for Security Technology Studies at Dartmouth
College pays him to work on network security and Linux projects.

Also contributing efforts go to Dave Dittrich from the University of
Washington, and Greg Shipley of Neohapsis

Matt Fearnow
SANS GIAC Incident Handler

If you have additional data on this worm or a critical quetsion  please
email lionworm@sans.org
------------ Output from pgp ------------
Signature by unknown keyid: 0xA1694E46


