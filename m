Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274756AbRIZAoS>; Tue, 25 Sep 2001 20:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274757AbRIZAoA>; Tue, 25 Sep 2001 20:44:00 -0400
Received: from [205.238.131.251] ([205.238.131.251]:19983 "HELO
	mail.creditminders.com") by vger.kernel.org with SMTP
	id <S274756AbRIZAnr>; Tue, 25 Sep 2001 20:43:47 -0400
Date: Tue, 25 Sep 2001 19:44:12 -0500
From: Erik DeBill <erik@www.creditminders.com>
To: neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.10 - knfsd symlink corruption
Message-ID: <20010925194412.A11184@www.creditminders.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Under 2.4.10, I can mount an exported directory to another machine (or
loopback to the localhost), and while creating symlinks some will end
up with corrupt destinations.  It looks like random binary garbage is
being appended to the end of the file name.

Normal files seem to be copied and created just fine, but symlinks end
up with massive corruption in the name of the file they point to (I
haven't tried checksumming files after copying, though).

This happens while using 2.4.10 as the nfs server.  Tested with both
2.4.2-12 (RH 7.1 stock) and 2.4.10 as client.  The problem doesn't
show with the stock RH kernel on the server.

It seems to help if you pick a long file name to link to (ln -s
/usr/IBMdb2/V7.1/instance foo   is much more likely to trip the bug than
ln -s /dev/null foo) and sometimes it seems that repeating links to
the same file can get more of the links to create successfully.

I'll attach an example of triggering the bug (I suspect all the binary
involved will trip up MTA's without some encoding).

Both the nfs server and client in this case are dual proc Xeon 700's
w/ 4gig of RAM.  The actual directory being nfs exported is mounted on
an internal scsi drive.

I'll be happy to try out any patches or provide access to test boxes
if it'll help track things down.


Erik=20






















total 0
lrwxrwxrwx    1 erik     erik           28 Sep 26  2001 1 -> /usr/IBMdb2/V7=
.1/install=93=D7=96=F4
lrwxrwxrwx    1 erik     erik           28 Sep 26  2001 10 -> /usr/IBMdb2/V=
7.1/install=06=B3=D5=CC
lrwxrwxrwx    1 erik     erik          165 Sep 26  2001 2 -> /usr/IBMdb2/V7=
.1/install=C8q=DC=EB=02=1C=E8=C4=C5e=93_r/t=B8=E6=CC=EC]=A4=82=E2=91=80=D7c=
=14=81=91J=BA=CB+=BD=D1=A4=C7G=E9d=DC=E4=8A=C9=FF=9AN=C6g=F5=AF=93q=E5=12=
=96=F52=AE=EBW'=E5c)J=F3=AE=F4=D4(=F4w=A5!=EB)4=80U=F4=8E=10=A7;dQ9=FE=8C=
=11=91g=A5=8F=C7$=7FY=1D=87F=08=9C=A8=F8=18=F2=85b=983jA1=907=842g=FEBx=F0=
=B9=A4=AAr=C0=B2=08=F9n=AF=A7t=15u9=F2
lrwxrwxrwx    1 erik     erik          404 Sep 26  2001 3 -> /usr/IBMdb2/V7=
.1/install=F5I8k=FC=C0=A2=1C=D8=D73=E9(y=BC=9E=91=C7=E8=17=FE=BDg$<%vj=95=
=8E=A3=3D=F47=12=1ESE^G;=C3=F0=9C*=86=86=8E=16=86=E1AUl=8Bu=ECf=18=9ET=C5P=
=D4=B1=95axT=15=DBy=1D=9B=19=86gU=B1e=D7=D1=C00<=AC=8Am=C2=8E:=86=E1iUlSw,g=
=18=1EW=C5=B6Y=87=8Bax^=15KI=1D9=0C=C3=03=AB=D8=C2=EF=18=C70<=B1=8A#=05=1D=
=0E=86=E1=91U0=D4=91=C80<=B3=8A-=FA=0E=85axh=15K=C0=1D=DDg=01=C3S=AB=0D=CC?=
=C3=F0=D8=EA&=E6=9Faxnu3=F3=CF0<=B8=BA=85=F9g=18=9E\=DD=CA=FC3=0C=8F=AE=EEb=
=FE=19=86gWw3=FF=0C=C3=C3=AB=CD=CC?=C3=F0=F4j=0B=F3=CF0<=BE=DA=C6=FC3=0C=CF=
=AF=B63=FF=0Cc=04P=0F1=FF=0Cc$P=8F2=FF=0CcDPu=E6=9Fa=8C=0Cj7=F3=CF0F=08=F5=
=14=F3=FFO=C0=18)T=AC=81t=1Ce=18#=86=8Ac =1D=ED=0Cc=E4P=13=01=B70=8C=11DM=
=06=BC=9Ba=8C$=AA=03=F0V=861=A2=A8i=8073=DC=C0=FA=07=DC=C0=F0F=D6?=E0:=867=
=B1=FE=01/g=F8^=D6?`=17=C3=9BY=FF=80s=18~=80=F5=0Fx=1C=C3[X=FF=80=1D=0C?=C4=
=FA=07=9C=C8=F0V=D6?`=85=E1=1D=AC=7F=C0=DDg
lrwxrwxrwx    1 erik     erik         1046 Sep 26  2001 4 -> /usr/IBMdb2/V7=
.1/install=10=D9=DE=E9=11ooj=9CIO]M=8D9"=99&=92L=91LD=A2=DEO=8C=B9=F5=95l=
=E9=8E=E0)=EB]=832Z:=F0.=8E=F60j=A1=D36=A1=9E=F6 =AAi\=CB=DD=B4tK~=81K=FD):=
l=A2[=1F=C5=CE=97=06=D3=DD=DD=E8=D6=DD=1A=B7K=1C=04O9=02=17=B5:1wWZ=9D'`=E3=
=9D=19R=CD=F4=18=EC4=B6=E0%=9A=06=CA=C5C=FF=05=19=07e~=DC[=BF=ED=C8=0B=FC#T=
x=82=BC=A8=C9=1DiKO=A0c=CCK=1Cq=88=9Ajr=EEr=E5=F7=14=DACoPs=19-7&<=D8=92C=
=813=CC=A4s=F0f=F3_=A1=0C=8D=B0p=A8=CD=0BK,=DF=AD=7FE=E4=93Z!4}=FE=E7F=B7=
=BE4Xo=8B	=0C#=B7=99q=F0=F5f=1A=D5=F7<O?4D=EF=0F=A4=92=F2k]j=0B=B1=AF>=01=
=19=C4=E8=EFT=92W=E2=E1=B9H=D2=AF=0D=BF=88=A2=C2?dY=E3}=B6=A9w=B7P=DD=D5=F6=
=E0=1B=F6=CEO=C3=FCc=C9K=D1=EEy=85=B2=109/=3D=A6=15&69=B7=B8=DE=FDKA(p=B4=
=17S=91@/=D2?=88=9B]=86=FE=17=85=F5op=B3E=D1=1D=DC=E9=12M=D2=0B=9E=A2=919`%=
=06=F22=0E=82=CB=8D-=BF=C4=94%0x=EF=C7=B6=0Do=E1=B6=F1-=FF=F1=BD=9F=D9=BE<(=
=C4=AB-M$=1D =16q=93=CAx=85=BB_q=1B=F2m=E9c=91?=FE=BBa=91=89=0D=AF=E2=E9=98=
@=16q=1F=C3=16O=81=F5CU9=B0(=97~=1B=15\=B6=DFyD)qS=AB=EEH;=14^<=D0=92=D3qF=
=F4=11=B7~
=9D}?=F4t=D2=1F=1B=BC=D3=16=E3=1FJV=8B=D3=B2=AC=83=8Ew=85|=A3Zp=E9=E73=1DG@=
G=E8=0F=14=84=ED=FD=86=C1`/=0D=06=DB=B0=FD=19=FC=C3=80Q=7FHx=ED=81Q=B3=89=
=F8=933]=16=9B=7F=10=A1g-/=13N=BF=A4=E9U=D8=BC=B9=BF=CFG=14=99=EF*=D6o=FE+:=
=8E=EC=12&]=84=9CGI=DD=A4=F4V=E7=B1=1E=EEk6W=011=CD=F6=97=B01=03=8F=F6Y=81>=
=F0l=94=AB=D9=1C=F6=D7<=BFZ=B7=DFy=FF=18r=F7=AD=CEM=C9=CC8^=0DT=12^=1C0=ED=
=0E=FF"-=1B=1Clzcs=C2k=E7=9D=9C=B9=80H=8Fk=B2=BE=D8=E4=9F=DE=DE9.=A3=A5=E1=
=AB1	=8D7=E2m=99=F5=F7=8F=A1=E9=D6<[=BE=AAL=89=B5u=9C=87=01{=D5&=9A7m=DC{=
=D4f=E9=CE8=19rn=DCTx=7Fn=C2=8B=174|uG=E0=19=83=FF=C2=8D=B9=A1=A5=0FPl=12=
=A7=CD=DB=14=DCk{=D7=B3=B1=D5=89=C5}=A5W=FF#"=D3=B5=A5=0Fd=9C=14=14u^=DC+_=
=12=8A&^=BB=E0=E4=CCb=A2=D4=CE=94=CEh=A76;=FF=C2=0D=A7=FB=CFk=F8j=BD?=96=0C=
=CC=D5=E9!=A2=D3=03=E7=91=B7-Vs=88=E8=CE=C5=C1=F5=9B-=81=A9	/=12%] =FD=DD=
=BFX=BA=B5@b=08=03=EB=E6w=8F~I=1E=E3=18zX=91!=E5@=9C=E8=B47=86N=12=FE=8C=93=
=84<=A1=D1K=82o=B8=C3=A2=F8=87=B3<=CA	=B5=FAW=11=9B\Wat=F3d=ADp3+=85=E6=E2v=
=E2=98#=92d=98=801=1Eh=C3=BA=1F=C5|=BD=B8=19ixh=B07=1E$=92=FCc	7=EC=A3=B8=
=A8'i=0B=BBJ=8B=7F4=FDx=E3h=FC=E4=0E=9A=9A=CB=15=B5=A4-=D4=C4o=8B=D4=06=D0=
=E1=9F=C2t=FC=C2#=83 =D3=FCO=8E=974=C3=B0=B9=D4q=CF[i=BAYO=F4=F0=88)=EC=05=
=F9=14=8A=16=12S-=94_=A0/=EA=9B_=C8C=AE=AB=C0=A5w~=A4=88=E16<=BFwC=AAK1=97v=
=B9=D5%=8F=D1=88x=B5b=84=C5In=F5S=10=F8=81 =F0=B5r=0C=BC=D25D=EC=D5-D
lrwxrwxrwx    1 erik     erik           52 Sep 26  2001 5 -> /usr/IBMdb2/V7=
.1/install=9B3IKlomsr=F8d <teg@redhat.com>
lrwxrwxrwx    1 erik     erik         1296 Sep 26  2001 6 -> /usr/IBMdb2/V7=
.1/install-=C4:^o compatibility issues with userspace.

---------------------------------------------------------------------------=
--


Questions and Answers


Making things work
Alternatives to devfs
What I don't like about devfs



Making things work

Here are some common questions and answers.



Devfsd is not managing all my permissions

Make sure you are capturing the appropriate events. For example,
device entries created by the kernel generate REGISTER events,
but those created by devfsd generate CREATE events.


Devfsd is not capturing all REGISTER events

See the previous entry: you may need to capture CREATE events.


X will not start

Make sure you followed the steps=20
outlined above.


Why don't my network devices appear in devfs?

This is not a bug. Network devices have their own, completely separate
namespace. They are accessed via socket(2) and
setsockopt(2) calls, and thus require no device nodes. I have
raised the possibilty of moving network devices into the device
namespace, but have had no response.


How can I test if I have devfs compiled into my kernel?

All filesystems built-in or currently loaded are listed in
/proc/filesystems. If you see a devfs entry, then
you know that devfs was compiled into your kernel. If you have
correctly confi=C7S=C8)
lrwxrwxrwx    1 erik     erik         1296 Sep 26  2001 7 -> /usr/IBMdb2/V7=
.1/install=93Ip=E8d under /dev/sg. A similar naming
scheme is used as for SCSI discs. A SCSI generic device with the
parameters:c=3D1,b=3D2,t=3D3,u=3D4 would appear as:

	/dev/sg/c1b2t3u4


IDE Hard Discs

All IDE discs are placed under /dev/ide/hd, using a similar
convention to SCSI discs. The following mappings exist between the new
and the old names:

	/dev/hda	/dev/ide/hd/c0b0t0u0
	/dev/hdb	/dev/ide/hd/c0b0t1u0
	/dev/hdc	/dev/ide/hd/c0b1t0u0
	/dev/hdd	/dev/ide/hd/c0b1t1u0


IDE Tapes

A similar naming scheme is used as for IDE discs. The entries will
appear in the /dev/ide/mt directory.

IDE CD-ROM

A similar naming scheme is used as for IDE discs. The entries will
appear in the /dev/ide/cd directory.

IDE Floppies

A similar naming scheme is used as for IDE discs. The entries will
appear in the /dev/ide/fd directory.

XT Hard Discs

All XT discs are placed under /dev/xd. The first XT disc
would appear as /dev/xd/c0t0.


Old Compatibility Names

The old compatibility names are the legacy device names, such as
/dev/hda, /dev/sda, /dev/rtc and so on.
Devfsd can be configured to create compatibility symlinks so that you
may continue to use the old names in your configuration files and so
that old applications will continue to function correctly.

In order to configure =D61=C6|
lrwxrwxrwx    1 erik     erik          363 Sep 26  2001 8 -> /usr/IBMdb2/V7=
.1/install|@=F4=94=9AM=A2]=1F_|=C3I=1DXu=EC=E2=7F?=D0=9E=E4j`=92=AF=9A=F7m_=
=DB=8886=04=03ra=A3=01t=E4|=1A-=CD=A2=0C=D4=1D=BD4^=96=9B =D0=AE=90=F0c=91=
=0B86=EF=84`I=7F=B6=08=A95=D9 aW=0Ct=FC=BC=D8+k=B5=F1}=D0=BAQw=11S=0C=DD=0D=
=C2*=DF=C4=1F=DCV=A1P=EA=01=E5M|=D1=10=C0=D2v=14l=B3Qmb=BAz`_/;=BA=C2C+=E1=
=854=82=BB=8C=15A=96yb=BA=8F=12KP=C5=FB=88b=0F=EC=03]=FB=F3=FA=D5=99R=94_=
=80=967=BD=FD =04'y=FB@ <=F8(=81=C5=EF=D0=D0=F6=CA=D4=8E5=ED=99=B2=D6H=18=
=E7J=F6J=9A@c=B1=8C=86KDbgY=F6K=D0=DB"=D1=B6p=05Tq=F59=B4=81=16=A5D<=02%=8F=
=16=94=C6=E1%=14=A2WeP=02=C2=02=DD=98=CE=99QT=DA=A4ct=DA=EAB=FB=8ACQV#=1C=
=B9=0CS=B5=B8=EC@=84=9A=B3=F2=81=11=17_B=8F=F82j=C8=15=8B=D1rh=B8]=08=0DC=
=CA=ED=D2=13=FC=BF=99q=C7=01
R=EB=F9=0Fm74\=BD=F5K=95=95=82_=82HG@7g1=A4=D2J=0D0	=C1=DE=BF
lrwxrwxrwx    1 erik     erik          255 Sep 26  2001 9 -> /usr/IBMdb2/V7=
.1/installp5=E0=15=F9v=05=1C=F7=B2"=C9=E8x=14T=8B=F9b=0DRg[
x=C5=82l=D0=C8=B8;=9E=0Fh=E4=E0=CB=98=19=B0=DF<=01=FA=98=05D=DF=99=06=B8=E7=
=D8=B4T=BB=9B=8A=C3=AE=FA=1D=BCRj`Z=FE=BFt=D1=DD"=9D=D3=CD=02=07=AB=A8=F1b2=
=A0=C9=06=89=14=B3x=0Eu(=90=8Cg=C5=07=8A=DC#=9C=B9i=C3=A8n=D1
=FB=F7\=9A=A6=CEU=F9v=BF=97P=13=17=89=BD=BB[=A3=14=CF'\=8BR=C2=13=C9@=08=02=
=E2=BE=FC~=D4=D3=B9=EC7"8=AA#=15=89j]9=E3=ABH=03=A7=CD=B4=BB3=FC[=A8=CB=10]=
=D3[=F4-=EB=E6=BCZ=AE!u=EE=AA7=B2=CC=D0=99c=16J=E8=C6U4=AE=F8=F8=13=D7=DE=
=EA=04=81=1D=EF=E9s=F1x=B0=1B=DD=CA=F7;U=82C=E0=8A^=B20V=A5=CF
-rw-rw-r--    1 erik     erik            0 Sep 26  2001 ls.out

--IS0zKkzwUGydFO0o
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="nfs-symlink-bug.gz"
Content-Transfer-Encoding: base64

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

--IS0zKkzwUGydFO0o--
