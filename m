Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129251AbQKTTEF>; Mon, 20 Nov 2000 14:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129411AbQKTTDq>; Mon, 20 Nov 2000 14:03:46 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:31748 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129251AbQKTTDc>; Mon, 20 Nov 2000 14:03:32 -0500
Message-ID: <3A196D87.7A408300@timpanogas.org>
Date: Mon, 20 Nov 2000 11:29:27 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: Linux 2.2.18pre22 (ISDN4K errors)]
Content-Type: multipart/mixed;
 boundary="------------A2BA14523C544E351BE8462D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A2BA14523C544E351BE8462D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


My NT box fritzed on sending this via outlook express, so I lost Kai's
email (MUTT works better on Linux).  Here's the other info he inquired
about on the 3.1pre1 compile problems.

Jeff
--------------A2BA14523C544E351BE8462D
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

X-Mozilla-Status2: 00000000
Message-ID: <3A1961C6.BA40C950@timpanogas.org>
Date: Mon, 20 Nov 2000 10:39:18 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
CC: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
 	linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre22 (ISDN4K errors)
In-Reply-To: <Pine.LNX.4.30.0011201818100.11607-100000@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------9E77210789CCBE71677361FD"

This is a multi-part message in MIME format.
--------------9E77210789CCBE71677361FD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


We were using the attached spec file for 3.1pre1 and the other file for
3.1beta7 (sorry I posted the wrong file, it was about 2 a.m. in the
morning).  When built against 2.2.18-21 with 3.1pre1, I get a whole new
slew of errors.  Neither seems to work.  I have attached the 3.1pre1
spec file which points to the newer version.  I removed the config and
kernel patches from the build since the last patch is for 2.2.14 and
fails to apply to 2.1.8-21.  Here are the results.  

against 2.2.18-pre21 and 2.4.0-10(11)

CAPI_GET_FLAGS undeclared
CAPI_SET_FLAGS undeclared
CAPI_CLR_FLAGS undeclared
CAPI_NCCI_GETUNIT undeclared
CAPI_NCCI_OPENCOUT undeclared.

Jeff
--------------9E77210789CCBE71677361FD
Content-Type: text/plain; charset=us-ascii;
 name="isdn4k-3.1-utils.spec"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isdn4k-3.1-utils.spec"

Summary: Bundled Utilities for configuring an using ISDN4Linux
Name: isdn4k-utils
Version: v3.1pre1
Release: 1
Copyright: GPL
Group: Base
Source0: ftp://ftp.franken.de/pub/isdn4linux/v2.0/isdn4k-utils-v3.1pre1.tar.gz
URL: http://www.isdn4linux.de
#Distribution: Unknown
Vendor: The ISDN4Linux Team
Packager: Fritz Elfert <fritz@isdn4linux.de>
Requires: kernel >= 2.0.36
BuildRoot: /var/tmp/isdn4k-utils-root

%description
isdn4k-utils is a collection of various ISDN related utilities. This
package contains configuration tools for all ISDN adapters, supported
by Linux. Furthermore, several status-monitors are provided as well as
some ISDN-based applications. Namely ipppd, a PPP daemon for synchronous
PPP over ISDN; vbox, an answering-machine and (for use with AVM-B1 only)
capifax, a faxmachine.

%prep
# remove old directory
if [ "X" != "${RPM_BUILD_ROOT}X" ]; then
	rm -rf $RPM_BUILD_ROOT
fi
rm -rf $RPM_BUILD_DIR/isdn4k-utils-%{PACKAGE_VERSION}
mkdir $RPM_BUILD_DIR/isdn4k-utils-%{PACKAGE_VERSION}

# unpack main sources
%setup -n isdn4k-utils-%{PACKAGE_VERSION}

%build
cp .config.rpm .config
make RPM_OPT_FLAGS="$RPM_OPT_FLAGS" subconfig
make RPM_OPT_FLAGS="$RPM_OPT_FLAGS"

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/usr/{sbin,bin,man,include}
mkdir -p $RPM_BUILD_ROOT/usr/lib/isdn
mkdir -p $RPM_BUILD_ROOT/etc/isdn
mkdir -p $RPM_BUILD_ROOT/dev
make DESTDIR=$RPM_BUILD_ROOT install
cd $RPM_BUILD_ROOT/etc/isdn
for i in *.new ; do
	mv $i `basename $i .new`
done

%clean
if [ "X" != "${RPM_BUILD_ROOT}X" ]; then
	rm -rf $RPM_BUILD_ROOT
fi

%files
/dev
/sbin
/usr/bin
/usr/lib/isdn
/usr/lib/libcapi20.a
/usr/include
/usr/X11R6/include/X11/bitmaps
%config /usr/X11R6/lib/X11/app-defaults/*
%dir /etc/isdn
%config /etc/isdn/vboxgetty.conf
%config /etc/isdn/vboxd.conf
%config /etc/isdn/isdn.conf
%doc /usr/man/man1/*
%doc /usr/man/man4/*
%doc /usr/man/man5/*
%doc /usr/man/man7/*
%doc /usr/man/man8/*
%doc /usr/doc/vbox/*
%doc /usr/X11R6/man/man1/*
%doc /usr/doc/faq/isdn4linux/*
%dir /var/spool/vbox
%dir /var/log/vbox

--------------9E77210789CCBE71677361FD--


--------------A2BA14523C544E351BE8462D--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
