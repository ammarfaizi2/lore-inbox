Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131911AbQL1Xos>; Thu, 28 Dec 2000 18:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132622AbQL1Xoi>; Thu, 28 Dec 2000 18:44:38 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:65290 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131911AbQL1Xod>; Thu, 28 Dec 2000 18:44:33 -0500
Date: Thu, 28 Dec 2000 17:09:21 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: 2.2.19 hard hang from userspace while accessing /dev/mdXX devices
Message-ID: <20001228170921.C22926@vger.timpanogas.org>
In-Reply-To: <20001228165948.A22926@vger.timpanogas.org> <E14BmAx-0004RD-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E14BmAx-0004RD-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 28, 2000 at 11:09:34PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii

On Thu, Dec 28, 2000 at 11:09:34PM +0000, Alan Cox wrote:
> > If you open a non-existant md device (i.e. /dev/md11) from userspace 
> > with an open() call, then send an ioctl() command, it results in the
> > following message then hard hangs the entire system if you attempt
> > to open any /dev/mdXX device with a minor number greater than 10.  
> > Used to work on 2.2.17.
> 
> What does 2.2.18 show and which raid patches are you using if any on them

2.2.18 pre 27 (2.2.18) exhibits identical behavior.  I am not using any 
RAID patches.  SPEC file used to build the kernel RPM is attached.  I am 
using the IPVS patch, and an iBCS2 patch (which does not touch the kernel,
just iBCS).  The SPEC file lists all the patches being applied to this 
kernel.

Jeff

> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kernel-2.2.18.spec"


Summary: The Linux 2.2.18 Kernel 
Name: kernel
%define sublevel 18
%define kversion 2.2.%{sublevel}
%define pcmciaver 3.1.22-23
%define ibcsver 2.1-981105
%define ksymoopsver 0.7c
# disable build root strip policy
%define __spec_install_post /usr/lib/rpm/brp-compress || :
Version: %{kversion}
Release: 27
%define KVERREL %{PACKAGE_VERSION}-%{PACKAGE_RELEASE}
Copyright: GPL
Group: System Environment/Kernel
ExclusiveArch: i386 i586 i686 alpha sparc sparc64
ExclusiveOS: Linux
Obsoletes: kernel-modules, kernel-sparc
Source0: ftp://ftp.kernel.org/pub/linux/kernel/v2.2/linux-%{kversion}.tar.gz
Source1: ftp://sourceforge.org/pcmcia/pcmcia-cs-%{pcmciaver}.tar.gz
Source2: ftp://tsx-11.mit.edu/pub/linux/BETA/ibcs2/ibcs-%{ibcsver}.tar.gz
Source3: ftp://ftp.ocs.com.au/pub/ksymoops/ksymoops-%{ksymoopsver}.tar.gz

Source10: pcmcia-cs-2.8.8-network.script
Source11: module-info
Source12: installkernel
Source14: kernel-2.2-BuildASM.sh

Source20: kernel-%{kversion}-i386.config
Source21: kernel-%{kversion}-i386-smp.config
Source22: kernel-%{kversion}-i386-BOOT.config
Source23: kernel-%{kversion}-alpha.config
Source24: kernel-%{kversion}-alpha-smp.config
Source25: kernel-%{kversion}-sparc.config
Source26: kernel-%{kversion}-sparc-smp.config
Source27: kernel-%{kversion}-sparc64.config
Source28: kernel-%{kversion}-sparc64-smp.config
Source29: kernel-%{kversion}-i686.config
Source30: kernel-%{kversion}-i686-smp.config
Source31: kernel-%{kversion}-alpha-BOOT.config
Source32: kernel-%{kversion}-sparc-BOOT.config
Source33: kernel-%{kversion}-sparc64-BOOT.config
Source34: kernel-%{kversion}-i586.config
Source35: kernel-%{kversion}-i586-smp.config

Patch98:  ipvs-1.0.0-2.2.17.patch
Patch99:  pre-patch-%{PACKAGE_VERSION}-%{PACKAGE_RELEASE}
Patch100: ibcs-2.1-rh.patch
Patch101: ibcs-2.1-locking.patch

BuildRoot: /var/tmp/kernel-%{KVERREL}-root
Provides: module-info
Autoreqprov: no
Requires: initscripts >= 3.64

Vendor: Timpanogas Research Group, Inc.
Packager: jmerkey@timpanogas.org

%package source
Requires: kernel-headers = %{kversion}
Summary: The source code for the Linux kernel.
Group: Development/System

%package headers
Summary: Header files for the Linux kernel.
Group: Development/System

%package doc
Summary: Various documentation bits found in the kernel source.
Group: Documentation

%package pcmcia-cs
Summary: The daemon and device drivers for using PCMCIA adapters.
Group: System Environment/Kernel
Obsoletes: pcmcia-cs

%package utils
Summary: Kernel related utilities.
Group: System Environment/Kernel

%package ibcs
Obsoletes: iBCS
Summary: Files which allow iBCS2 programs to run.
Group: System Environment/Kernel

%description
The kernel package contains the Linux kernel (vmlinuz), the core of your
Linux operating system.  The kernel handles the basic functions
of the operating system:  memory allocation, process allocation, device
input and output, etc.

%description source
The kernel-source package contains the source code files for the Linux
kernel. These source files are needed to build most C programs, since
they depend on the constants defined in the source code. The source
files can also be used to build a custom kernel that is better tuned
to your particular hardware, if you are so inclined (and you know what
you're doing).

%description headers
Kernel-headers includes the C header files for the Linux kernel.  The
header files define structures and constants that are needed for
building most standard programs and are also needed for rebuilding the
kernel.

%description doc
This package contains documentation files form the kernel
source. Various bits of information about the Linux kernel and the
device drivers shipped with it are documented in these files. 

You'll want to install this package if you need a reference to the
options that can be passed to Linux kernel modules at load time.

%description pcmcia-cs
Many laptop machines (and some non-laptops) support PCMCIA cards for
expansion. Also known as "credit card adapters," PCMCIA cards are
small cards for everything from SCSI support to modems. PCMCIA cards
are hot swappable (i.e., they can be exchanged without rebooting the
system) and quite convenient to use. The kernel-pcmcia-cs package
contains a set of loadable kernel modules that implement an
applications program interface, a set of client drivers for specific
cards and a card manager daemon that can respond to card insertion and
removal events by loading and unloading drivers on demand.  The daemon
also supports hot swapping, so that the cards can be safely inserted
and ejected at any time.

Install the kernel-pcmcia-cs package if your system uses PCMCIA
cards.

%description utils
The kernel-utils package contains ksymoops, a utility that can be used
for decrypting the kernel's OOPS output.

%description ibcs
The kernel-ibcs package allows you to run programs in the iBCS2 (Intel
Binary Compatibility Standard, version 2) and related executable
formats.  iBCS is a standard for binary portability between UNIX and
UNIX-like systems.

%package smp
Summary: The Linux kernel compiled for SMP machines.
Group: System Environment/Kernel
Provides: kernel = %{version}

%description smp
This package includes a SMP version of the Linux kernel. It is
required only on machines with two or more CPUs, although it should
work fine on single-CPU boxes.

Install the kernel-smp package if your machine uses two or more CPUs.

%package BOOT
Summary: The version of the Linux kernel used on installation boot disks.
Group: System Environment/Kernel
Provides: kernel = %{version}

%description BOOT
This package includes a trimmed down version of the Linux kernel.
This kernel is used on the installation boot disks only and should not
be used for an installed system, as many features in this kernel are
turned off because of the size constraints.

%package BOOTsmp
Summary: The Linux kernel used for boot disks for Alpha SMP machines.
Group: System Environment/Kernel
Provides: kernel = %{version}

%description BOOTsmp
This package includes a trimmed down version of the Alpha Linux kernel. This
kernel is used on the installation boot disks only and should not be used
for an installed system, as many features in this kernel are turned off
because of the size constraints. This kernel is used when booting SMP
machines that have trouble coming up to life with the uniprocessor kernel.

%prep
%setup -q -n linux -a 1 -a 2 -a 3
mkdir configs
cp -fv $RPM_SOURCE_DIR/kernel-%{version}*.config configs

%patch98 -p1
%patch99 -p1

# PCMCIA, IBCS
%ifarch i386 i586 i686
%patch100 -p0
%patch101 -p0
cd pcmcia-cs-%{pcmciaver}

cd ..
cp ibcs/CONFIG.i386 ibcs/CONFIG
%else
rm -rf pcmcia-cs-%{pcmciaver}
rm -rf ibcs
%endif

# Basically, this sucks. Shipping kernel source with procompiled binaries,
# that is. And having 'make mrproper' not cleaning that up either
make clean -C scripts/ksymoops

# make sure the kernel has the sublevel we know it has...
perl -p -i -e "s/^SUBLEVEL.*/SUBLEVEL = %{sublevel}/" Makefile

# get rid of unwanted files
find . -name "*.orig" -exec rm -fv {} \;

###
### build
###
%build

if [ -x /usr/bin/getconf ] ; then
    NRPROC=$(/usr/bin/getconf _NPROCESSORS_ONLN)
    if [ $NRPROC -eq 0 ] ; then
	NRPROC=1
    fi
else
    NRPROC=1
fi

BuildKernel() {
    # is this a special kernel we want to build?
    if [ -n "$1" ] ; then
	Config=%{_target_cpu}-$1
	KernelVer=%{version}-%{release}$1
	echo BUILDING A KERNEL FOR $1...
    else
	Config=%{_target_cpu}
	KernelVer=%{version}-%{release}
	echo BUILDING THE NORMAL KERNEL...
    fi
%ifarch sparc64
    cp $RPM_SOURCE_DIR/kernel-%{kversion}-$Config.config arch/%{_target_cpu}/defconfig
%else
    cp $RPM_SOURCE_DIR/kernel-%{kversion}-$Config.config arch/%{_arch}/defconfig
%endif
    rm -f .config
    # make sure EXTRAVERSION says what we want it to say
    perl -p -i -e "s/^EXTRAVERSION.*/EXTRAVERSION = -%{release}$1/" Makefile
    make mrproper

    make oldconfig
    #make config

    # save new config back to source dir
    cp .config $RPM_SOURCE_DIR/kernel-%{kversion}-$Config.config 

    make dep
    make include/linux/version.h 
%ifarch i386 i586 i686
    make -j $NRPROC bzImage MAKE="make -j $NRPROC"
%else
    make boot MAKE="make -j $NRPROC"
%endif
    make -j $NRPROC modules MAKE="make -j $NRPROC"
    # first make sure we are not loosing any .ver files to make mrporper's
    # removal of zero sized files.
    find include/linux/modules -size 0 | while read file ; do \
	echo > $file
    done
    # Start installing stuff
    mkdir -p $RPM_BUILD_ROOT/boot
    install -m 644 System.map $RPM_BUILD_ROOT/boot/System.map-$KernelVer
    install -m 644 $RPM_SOURCE_DIR/module-info $RPM_BUILD_ROOT/boot/module-info-$KernelVer
%ifarch i386 i586 i686
    cp arch/i386/boot/bzImage $RPM_BUILD_ROOT/boot/vmlinuz-$KernelVer
    cp vmlinux $RPM_BUILD_ROOT/boot/vmlinux-$KernelVer
%else
    gzip -cfv vmlinux > vmlinuz
    install -m 755 vmlinux $RPM_BUILD_ROOT/boot/vmlinux-$KernelVer
    install -m 644 vmlinuz $RPM_BUILD_ROOT/boot/vmlinuz-$KernelVer
%endif
    mkdir -p $RPM_BUILD_ROOT/lib/modules/$KernelVer/{block,cdrom,fs,ipv4,misc,net,scsi,video}
    make INSTALL_MOD_PATH=$RPM_BUILD_ROOT modules_install KERNELRELEASE=$KernelVer

}

BuildiBCS() {
    if [ -z "$2" ] ; then
	echo "BUILDING FOR NORMAL KERNEL..."
    else
	echo "BUILDING FOR $2..."
    fi
    make -j $NRPROC -C ibcs/iBCSemul KERNEL=$RPM_BUILD_DIR/linux SMP=$1 all
    install -m644 ibcs/iBCSemul/iBCS \
	$RPM_BUILD_ROOT/lib/modules/%{KVERREL}$2/misc/iBCS.o
    make -C ibcs clean 
}

BuildPCMCIA() {
    if [ -z "$1" ] ; then
	echo "BUILDING FOR NORMAL KERNEL..."
    else
	echo "BUILDING FOR $1..."
    fi
    
    make -C pcmcia-cs-%{pcmciaver} clean 

    cd pcmcia-cs-%{pcmciaver}
    ./Configure -n --kernel=$RPM_BUILD_DIR/linux --target=$RPM_BUILD_ROOT \
                   --moddir=/lib/modules/%{KVERREL}$1 --arch=%{_arch} \
                   --trust --cardbus --nopnp --srctree --sysv \
                   --rcdir=/etc/rc.d
    cd ..

    make -j $NRPROC MAKE="make -j $NRPROC" -C pcmcia-cs-%{pcmciaver} all
    mkdir -p $RPM_BUILD_ROOT/lib/modules/%{KVERREL}$1/pcmcia
    make -C pcmcia-cs-%{pcmciaver} install 
}

SaveHeaders() {
    if [ -n "$1" ] ; then
	echo "SAVING HEADERS for $1"
    fi
    # deal with the kernel headers that are version specific
    mkdir -p $RPM_BUILD_ROOT/usr/src/linux-%{kversion}/include/linux
    if [ -n "$1" ] ; then
    	install -m 644 include/linux/autoconf.h \
	    $RPM_BUILD_ROOT/usr/src/linux-%{kversion}/include/linux/autoconf-$1.h
    	install -m 644 include/linux/version.h \
	    $RPM_BUILD_ROOT/usr/src/linux-%{kversion}/include/linux/version-$1.h
	sed -e "s,/modules/,/modules-$1/,g" < include/linux/modversions.h > \
	    $RPM_BUILD_ROOT/usr/src/linux-%{kversion}/include/linux/modversions-$1.h
	mv include/linux/modules include/linux/modules-$1
	
    fi
}

###
# DO it...
###

rm -rf $RPM_BUILD_ROOT

#SMP-ENABLED KERNEL
BuildKernel smp
%ifarch i386 i586 i686
BuildiBCS yes smp
BuildPCMCIA smp
%endif
SaveHeaders smp

%ifnarch i586 i686
# BOOT kernel
BuildKernel BOOT
%ifarch i386
BuildPCMCIA BOOT
%endif
SaveHeaders BOOT
#%ifarch alpha
#BuildKernel BOOTsmp
#SaveHeaders BOOTsmp
#%endif
%endif

# NORMAL KERNEL
BuildKernel
%ifarch i386 i586 i686
BuildiBCS no
BuildPCMCIA
%endif
%ifarch i386 alpha sparc
SaveHeaders up
%endif

%ifarch i386 alpha sparc
make -C ksymoops-%{ksymoopsver}
%endif

###
### install
###

%install

mkdir -p $RPM_BUILD_ROOT/{boot,sbin}
install -m 755 $RPM_SOURCE_DIR/installkernel $RPM_BUILD_ROOT/sbin/installkernel

%ifarch i586 i686 sparc64
# these don't need much
exit 0
%endif

mkdir -p $RPM_BUILD_ROOT/usr/include
ln -sf ../src/linux/include/linux $RPM_BUILD_ROOT/usr/include/linux

mkdir -p $RPM_BUILD_ROOT/usr/src/linux-%{kversion} 

%ifarch i386
mkdir -p $RPM_BUILD_ROOT/etc/pcmcia
mkdir -p $RPM_BUILD_ROOT/etc/sysconfig
# Install our own network up/down script
install -m755 $RPM_SOURCE_DIR/pcmcia-cs-2.8.8-network.script \
        $RPM_BUILD_ROOT/etc/pcmcia/network

# We need our own default /etc/sysconfig/pcmcia
cat > $RPM_BUILD_ROOT/etc/sysconfig/pcmcia <<EOF
PCMCIA=no
PCIC=
PCIC_OPTS=do_scan=0
CORE_OPTS=
EOF

# Finally strip some binaries
for file in cardmgr cardctl probe scsi_info ftl_format ftl_check ; do
    strip $RPM_BUILD_ROOT/sbin/$file
done

# iBCS stuff
mkdir -p $RPM_BUILD_ROOT/usr/man/man9
install -m 644 ibcs/Doc/iBCS.9 $RPM_BUILD_ROOT/usr/man/man9

mkdir -p $RPM_BUILD_ROOT/dev/inet
install -m755 ibcs/MAKEDEV.ibcs $RPM_BUILD_ROOT/dev/MAKEDEV.ibcs
pushd $RPM_BUILD_ROOT ; {
  mknod ./dev/socksys c 30 0
  ln -s socksys ./dev/nfsd
  ln -s null ./dev/X0R
  mknod ./dev/spx c 30 1
  mknod ./dev/inet/ip c 30 32
  mknod ./dev/inet/icmp c 30 33
  mknod ./dev/inet/ggp c 30 34
  mknod ./dev/inet/ipip c 30 35
  mknod ./dev/inet/tcp c 30 36
  mknod ./dev/inet/egp c 30 37
  mknod ./dev/inet/pup c 30 38
  mknod ./dev/inet/udp c 30 39
  mknod ./dev/inet/idp c 30 40
  mknod ./dev/inet/rawip c 30 41
  ln -s udp ./dev/inet/arp
  ln -s udp ./dev/inet/rip
  cd ./dev/inet
  for i in *; do
    ln -s inet/$i ../$i
  done
} ; popd
%endif

mkdir -p $RPM_BUILD_ROOT/usr/src/linux-%{kversion}
tar cf - . | tar xf - -C $RPM_BUILD_ROOT/usr/src/linux-%{kversion}
ln -sf linux-%{kversion} $RPM_BUILD_ROOT/usr/src/linux

%ifarch sparc
ln -s ../src/linux/include/asm-sparc $RPM_BUILD_ROOT/usr/include/asm-sparc
ln -s ../src/linux/include/asm-sparc64 $RPM_BUILD_ROOT/usr/include/asm-sparc64
mkdir $RPM_BUILD_ROOT/usr/include/asm
cp -a $RPM_SOURCE_DIR/kernel-2.2-BuildASM.sh $RPM_BUILD_ROOT/usr/include/asm/BuildASM
$RPM_BUILD_ROOT/usr/include/asm/BuildASM $RPM_BUILD_ROOT/usr/include
%else
ln -sf ../src/linux/include/asm $RPM_BUILD_ROOT/usr/include/asm
%endif

#clean up the destination
%ifarch i386
make clean -C $RPM_BUILD_ROOT/usr/src/linux-%{kversion}/pcmcia-cs-%{pcmciaver}
make -C $RPM_BUILD_ROOT/usr/src/linux-%{kversion}/ibcs clean
%endif

make mrproper -C $RPM_BUILD_ROOT/usr/src/linux-%{kversion}
make oldconfig -C $RPM_BUILD_ROOT/usr/src/linux-%{kversion}
make symlinks -C $RPM_BUILD_ROOT/usr/src/linux-%{kversion}
make include/linux/version.h -C $RPM_BUILD_ROOT/usr/src/linux-%{kversion}

#this generates modversions info which we want to include and we may as
#well include the depends stuff as well, after we fix the paths
make depend -C $RPM_BUILD_ROOT/usr/src/linux-%{kversion}
find $RPM_BUILD_ROOT/usr/src/linux-%{kversion} -name ".*depend" | \
while read file ; do
    mv $file $file.old
    sed -e "s|[^ ]*\(/usr/src/linux\)|\1|g" < $file.old > $file
    rm -f $file.old
done

# other tools
make install -C ksymoops-%{ksymoopsver} INSTALL_PREFIX=$RPM_BUILD_ROOT/usr

###
### clean
###

%clean
rm -rf $RPM_BUILD_ROOT

###
### scripts
###

# do this for upgrades...in case the old modules get removed we have
# loopback in the kernel so that mkinitrd will work.
%pre
/sbin/modprobe loop 2> /dev/null > /dev/null
exit 0

%post
cd /boot
ln -sf vmlinuz-%{KVERREL} vmlinuz
ln -sf System.map-%{KVERREL} System.map
ln -sf module-info-%{KVERREL} module-info

# Allow clean removal of modules directory
%preun
rm -f /lib/modules/%{KVERREL}/modules.dep

%preun smp
rm -f /lib/modules/%{KVERREL}smp/modules.dep

%preun BOOT
rm -f /lib/modules/%{KVERREL}BOOT/modules.dep

%ifarch i386 i586 i686
if [ -x /sbin/lilo -a -f /etc/lilo.conf ]; then
	/sbin/lilo > /dev/null 2>&1
	exit 0
fi
%endif

%post headers
cd /usr/src
rm -f linux
ln -snf linux-%{kversion} linux

%post source
cd /usr/src
rm -f linux
ln -snf linux-%{kversion} linux

%postun headers
if [ -L /usr/src/linux ]; then 
    if [ `ls -l /usr/src/linux | awk '{ print $11 }'` = "linux-%{kversion}" ]; then
	[ $1 = 0 ] && rm -f /usr/src/linux
    fi
fi
exit 0

%postun source
if [ -L /usr/src/linux ]; then 
    if [ `ls -l /usr/src/linux | awk '{ print $11 }'` = "linux-%{kversion}" ]; then
	[ $1 = 0 ] && rm -f /usr/src/linux
    fi
fi
exit 0

%ifarch i386
%post pcmcia-cs
/sbin/chkconfig --add pcmcia

%preun pcmcia-cs
if [ $1 = 0 ]; then
    /sbin/chkconfig --del pcmcia
fi
exit 0

%triggerpostun -- kernel-pcmcia-cs < 2.2.5
if [ -f /etc/rc.d/init.d/pcmcia ] ; then
    /sbin/chkconfig --add pcmcia
fi

%endif

###
### file lists
###

%files
%defattr(-,root,root)
/boot/vmlinux-%{KVERREL}
/boot/vmlinuz-%{KVERREL}
/boot/System.map-%{KVERREL}
/boot/module-info-%{KVERREL}
%config /sbin/installkernel
%dir /lib/modules
/lib/modules/%{KVERREL}

%files smp
%defattr(-,root,root)
/boot/vmlinux-%{KVERREL}smp
/boot/vmlinuz-%{KVERREL}smp
/boot/System.map-%{KVERREL}smp
/boot/module-info-%{KVERREL}smp
%config /sbin/installkernel
%dir /lib/modules
/lib/modules/%{KVERREL}smp

%ifnarch i586 i686
%files BOOT
%defattr(-,root,root)
/boot/vmlinux-%{KVERREL}BOOT
/boot/vmlinuz-%{KVERREL}BOOT
/boot/System.map-%{KVERREL}BOOT
%config /sbin/installkernel
%dir /lib/modules
/lib/modules/%{KVERREL}BOOT
%endif

#%ifarch alpha
#%files BOOTsmp
#%defattr(-,root,root)
#/boot/vmlinux-%{KVERREL}BOOTsmp
#/boot/vmlinuz-%{KVERREL}BOOTsmp
#/boot/System.map-%{KVERREL}BOOTsmp
#%config /sbin/installkernel
#%dir /lib/modules
#/lib/modules/%{KVERREL}BOOTsmp
#%endif

%ifnarch i586 i686 sparc64
# START BASE ARCHES ONLY
%ifarch i386 alpha sparc

%files source
%defattr(-,root,root)
/usr/src/linux-%{kversion}/COPYING
/usr/src/linux-%{kversion}/CREDITS
/usr/src/linux-%{kversion}/Documentation
/usr/src/linux-%{kversion}/MAINTAINERS
/usr/src/linux-%{kversion}/Makefile
/usr/src/linux-%{kversion}/README
/usr/src/linux-%{kversion}/REPORTING-BUGS
/usr/src/linux-%{kversion}/Rules.make
/usr/src/linux-%{kversion}/arch/%{_arch}
%ifarch sparc
/usr/src/linux-%{kversion}/arch/sparc64
%endif
/usr/src/linux-%{kversion}/drivers
/usr/src/linux-%{kversion}/fs
/usr/src/linux-%{kversion}/init
/usr/src/linux-%{kversion}/ipc
/usr/src/linux-%{kversion}/kernel
/usr/src/linux-%{kversion}/lib
/usr/src/linux-%{kversion}/mm
/usr/src/linux-%{kversion}/modules
/usr/src/linux-%{kversion}/net
/usr/src/linux-%{kversion}/scripts
%ifarch i386
/usr/src/linux-%{kversion}/ibcs
/usr/src/linux-%{kversion}/pcmcia-cs-%{pcmciaver}
%endif

%files utils
%defattr(-,root,root)
%doc scripts/ksymoops/README
/usr/bin/ksymoops
/usr/man/man8/ksymoops.8*

%files headers
%defattr(-,root,root)
%dir /usr/src/linux-%{kversion}
/usr/src/linux-%{kversion}/configs
%ifarch sparc
/usr/src/linux-%{kversion}/include/asm-sparc
/usr/src/linux-%{kversion}/include/asm-sparc64
/usr/include/asm-sparc
/usr/include/asm-sparc64
%else
/usr/src/linux-%{kversion}/include/asm-%{_arch}
%endif
/usr/src/linux-%{kversion}/include/asm
/usr/src/linux-%{kversion}/include/asm-generic
/usr/src/linux-%{kversion}/include/linux
/usr/src/linux-%{kversion}/include/net
/usr/src/linux-%{kversion}/include/scsi
/usr/src/linux-%{kversion}/include/video
%ifarch alpha sparc
/usr/src/linux-%{kversion}/include/math-emu
%endif  
/usr/include/asm
/usr/include/linux

%files doc
%defattr(-,root,root)
%doc Documentation/*

%endif
# END BASE ARCHES ONLY
%endif

%ifarch i386
%files pcmcia-cs
%defattr(-,root,root)
%doc pcmcia-cs-%{pcmciaver}/doc/PCMCIA-HOWTO 
%doc pcmcia-cs-%{pcmciaver}/doc/PCMCIA-PROG
%doc pcmcia-cs-%{pcmciaver}/SUPPORTED.CARDS 
%doc pcmcia-cs-%{pcmciaver}/CHANGES 
%doc pcmcia-cs-%{pcmciaver}/COPYING 
%doc pcmcia-cs-%{pcmciaver}/README
%attr(755,root,root) /sbin/cardctl
/sbin/cardmgr
/sbin/ftl_check
/sbin/ftl_format
/sbin/ifport
/sbin/ifuser
/sbin/pcinitrd
/sbin/probe
/sbin/scsi_info
/usr/man/man[458]/*
%config /etc/rc.d/init.d/pcmcia
# The installer will put the right information in it. We should
# install the new one with extension .rpmnew since it is not
# correct for notebook. H.J.
%config(noreplace) /etc/sysconfig/pcmcia
%dir /etc/pcmcia
/etc/pcmcia/config
/etc/pcmcia/ftl
/etc/pcmcia/ide
/etc/pcmcia/memory
/etc/pcmcia/network
/etc/pcmcia/scsi
/etc/pcmcia/serial
/etc/pcmcia/shared
/etc/pcmcia/cis
%config /etc/pcmcia/config.opts
%config /etc/pcmcia/ftl.opts
%config /etc/pcmcia/ide.opts
%config /etc/pcmcia/memory.opts
%config /etc/pcmcia/scsi.opts
%config /etc/pcmcia/serial.opts
%endif

%ifarch i386
%files ibcs
%defattr(-,root,root)
%doc ibcs/{README,RELEASE,CREDITS,Doc}
/usr/man/man9/iBCS.9*
/dev/MAKEDEV.ibcs
/dev/inet
/dev/socksys
/dev/nfsd
/dev/X0R
/dev/spx
/dev/arp
/dev/egp
/dev/ggp
/dev/icmp
/dev/idp
/dev/ip
/dev/ipip
/dev/pup
/dev/rawip
/dev/rip
/dev/tcp
/dev/udp
%endif

%changelog

--nFreZHaLTZJo0R7j--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
