Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbTDEB5I (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 20:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbTDEB5I (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 20:57:08 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:3336 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261695AbTDEBze (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 20:55:34 -0500
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Date: Sat, 05 Apr 2003 02:06:50 +0000 (GMT)
Subject: BK-kernel-tools/shortlog update (part 1 of 2)
Content-type: message/partial; id="500.13515.1049508410.merlin"; number=1; total=2
MIME-Version: 1.0
Message-Id: <20030405020651.527065EE70@merlin.emma.line.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MIME-Version: 1.0
To: torvalds@transmeta.com
Subject: BK-kernel-tools/shortlog update
CC: linux-kernel@vger.kernel.org,matthias.andree@gmx.de,samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Sat_Apr__5_02_06_50_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain
Content-Description: An object packed by metasend
Content-Transfer-Encoding: quoted-printable

Hello Linus,

you can either use bk receive to patch this mail, you can pull from
bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no trailing slash)
or you can apply the patch below.

Patch description:
Address obfuscation, minor improvements -- see below.

Matthias
##### DIFFSTAT #####
# shortlog | 1693 ++++++++++++++++++++++---------------------
# 1 files changed, 870 insertions(+), 823 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or high=
er.
# This patch includes the following deltas:
#	           ChangeSet	1.45    -> 1.46   =

#	            shortlog	1.21    -> 1.22   =

#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/04/05	matthias.andree@gmx.de	1.46
# Obfuscate addresses. Omit email address when name is known.
# --ignoremerge improvements. New addresses
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Sat Apr  5 04:06:50 2003
+++ b/shortlog	Sat Apr  5 04:06:50 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.89 2003/03/28 10:55:39 emma Exp $
+# $Id: lk-changelog.pl,v 0.93 2003/04/03 10:48:46 vita Exp $
 # ----------------------------------------------------------------------=

 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -68,826 +68,842 @@
 # Perl syntax magic here, "=3D>" is equivalent to ","
 my @addrregexps =3D (
 [ 'alan@.*\.swansea\.linux\.org\.uk' =3D> 'Alan Cox', ],
+[ 'torvalds@(.*\.)?transmeta\.com' =3D> 'Linus Torvalds', ],
 [ '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~' =3D> '~~~~~~~~' ]);
 =

+sub obfuscate(@) {
+  my @a =3D @_;
+  map { tr/@/:/ } @a;
+  return wantarray ? @a : $a[0];
+};
+
+sub unveil(@) {
+  my @a =3D @_;
+  map { tr/:/@/ } @a;
+  return wantarray ? @a : $a[0];
+};
+
 # the key is the email address in ALL LOWER CAPS!
 # the value is the real name of the person
 #
 # Unless otherwise noted, the addresses below have been obtained using
 # lbdb.
 my %addresses =3D (
-'abraham@2d3d.co.za' =3D> 'Abraham van der Merwe',
-'abslucio@terra.com.br' =3D> 'Lucio Maciel',
-'ac9410@attbi.com' =3D> 'Albert Cranford',
-'acher@in.tum.de' =3D> 'Georg Acher',
-'achirica@ttd.net' =3D> 'Javier Achirica',
-'acme@brinquedo.oo.ps' =3D> 'Arnaldo Carvalho de Melo',
-'acme@conectiva.com.br' =3D> 'Arnaldo Carvalho de Melo',
-'acme@dhcp197.conectiva' =3D> 'Arnaldo Carvalho de Melo',
-'acurtis@onz.com' =3D> 'Allen Curtis',
-'adam@mailhost.nmt.edu' =3D> 'Adam Radford', # google
-'adam@nmt.edu' =3D> 'Adam Radford', # google
-'adam@yggdrasil.com' =3D> 'Adam J. Richter',
-'adaplas@pol.net' =3D> 'Antonino Daplas',
-'adilger@clusterfs.com' =3D> 'Andreas Dilger',
-'aebr@win.tue.nl' =3D> 'Andries E. Brouwer',
-'agrover@acpi3.(none)' =3D> 'Andy Grover',
-'agrover@acpi3.jf.intel.com' =3D> 'Andy Grover', # guessed
-'agrover@dexter.groveronline.com' =3D> 'Andy Grover',
-'agrover@groveronline.com' =3D> 'Andy Grover',
-'agruen@suse.de' =3D> 'Andreas Gruenbacher',
-'ahaas@airmail.net' =3D> 'Art Haas',
-'ahaas@neosoft.com' =3D> 'Art Haas',
-'aia21@cam.ac.uk' =3D> 'Anton Altaparmakov',
-'aia21@cantab.net' =3D> 'Anton Altaparmakov',
-'aia21@cus.cam.ac.uk' =3D> 'Anton Altaparmakov',
-'ajoshi@kernel.crashing.org' =3D> 'Ani Joshi',
-'ajoshi@shell.unixbox.com' =3D> 'Ani Joshi',
-'ak@muc.de' =3D> 'Andi Kleen',
-'ak@suse.de' =3D> 'Andi Kleen',
-'akpm@digeo.com' =3D> 'Andrew Morton',
-'akpm@zip.com.au' =3D> 'Andrew Morton',
-'akropel1@rochester.rr.com' =3D> 'Adam Kropelin', # lbdb
-'alan@lxorguk.ukuu.org.uk' =3D> 'Alan Cox',
-'alan@redhat.com' =3D> 'Alan Cox',
-'alex@ssi.bg' =3D> 'Alexander Atanasov',
-'alex_williamson@attbi.com' =3D> 'Alex Williamson', # lbdb
-'alex_williamson@hp.com' =3D> 'Alex Williamson', # google
-'alexander.riesen@synopsys.com' =3D> 'Alexander Riesen',
-'alexey@technomagesinc.com' =3D> 'Alex Tomas',
-'alfre@ibd.es' =3D> 'Alfredo Sanju=E1n',
-'ambx1@neo.rr.com' =3D> 'Adam Belay',
-'amunoz@vmware.com' =3D> 'Alberto Munoz',
-'andersen@codepoet.org' =3D> 'Erik Andersen',
-'andersg@0x63.nu' =3D> 'Anders Gustafsson',
-'andmike@us.ibm.com' =3D> 'Mike Anderson', # lbdb
-'andrea@suse.de' =3D> 'Andrea Arcangeli',
-'andrew.wood@ivarch.com' =3D> 'Andrew Wood',
-'andries.brouwer@cwi.nl' =3D> 'Andries E. Brouwer',
-'andros@citi.umich.edu' =3D> 'Andy Adamson',
-'andre.breiler@null-mx.org' =3D> 'Andr=E9 Breiler',
-'angus.sawyer@dsl.pipex.com' =3D> 'Angus Sawyer',
-'ankry@green.mif.pg.gda.pl' =3D> 'Andrzej Krzysztofowicz',
-'anton@samba.org' =3D> 'Anton Blanchard',
-'aris@cathedrallabs.org' =3D> 'Aristeu Sergio Rozanski Filho',
-'arjan@redhat.com' =3D> 'Arjan van de Ven',
-'arjanv@redhat.com' =3D> 'Arjan van de Ven',
-'arnd@arndb.de' =3D> 'Arnd Bergmann',
-'arnd@bergmann-dalldorf.de' =3D> 'Arnd Bergmann',
-'arndb@de.ibm.com' =3D> 'Arnd Bergmann',
-'arun.sharma@intel.com' =3D> 'Arun Sharma',
-'asit.k.mallick@intel.com' =3D> 'Asit K. Mallick', # by Kristian Peters
-'axboe@burns.home.kernel.dk' =3D> 'Jens Axboe', # guessed
-'axboe@hera.kernel.org' =3D> 'Jens Axboe',
-'axboe@suse.de' =3D> 'Jens Axboe',
-'baccala@vger.freesoft.org' =3D> 'Brent Baccala',
-'baldrick@wanadoo.fr' =3D> 'Duncan Sands',
-'ballabio_dario@emc.com' =3D> 'Dario Ballabio',
-'barrow_dj@yahoo.com' =3D> 'D. J. Barrow',
-'barryn@pobox.com' =3D> 'Barry K. Nathan', # lbdb
-'bart.de.schuymer@pandora.be' =3D> 'Bart De Schuymer',
-'bcollins@debian.org' =3D> 'Ben Collins',
-'bcrl@bob.home.kvack.org' =3D> 'Benjamin LaHaise',
-'bcrl@redhat.com' =3D> 'Benjamin LaHaise',
-'bcrl@toomuch.toronto.redhat.com' =3D> 'Benjamin LaHaise', # guessed
-'bde@bwlink.com' =3D> 'Bruce D. Elliott',	# it's typo IMHO
-'bde@nwlink.com' =3D> 'Bruce D. Elliott',
-'bdschuym@pandora.be' =3D> 'Bart De Schuymer',
-'beattie@beattie-home.net' =3D> 'Brian Beattie', # from david.nelson
-'benh@kernel.crashing.org' =3D> 'Benjamin Herrenschmidt',
-'benh@zion.wanadoo.fr' =3D> 'Benjamin Herrenschmidt',
-'bergner@vnet.ibm.com' =3D> 'Peter Bergner',
-'bero@arklinux.org' =3D> 'Bernhard Rosenkraenzer',
-'bfennema@falcon.csc.calpoly.edu' =3D> 'Ben Fennema',
-'bgerst@didntduck.org' =3D> 'Brian Gerst',
-'bhards@bigpond.net.au' =3D> 'Brad Hards',
-'bhavesh@avaya.com' =3D> 'Bhavesh P. Davda',
-'bheilbrun@paypal.com' =3D> 'Brad Heilbrun', # by himself
-'bjorn.andersson@erc.ericsson.se' =3D> 'Bj=F6rn Andersson', # google, gu=
essed =F6
-'bjorn.wesen@axis.com' =3D> 'Bjorn Wesen',
-'bjorn_helgaas@hp.com' =3D> 'Bjorn Helgaas',
-'blaschke@blaschke3.austin.ibm.com' =3D> 'Dave Blaschke',
-'blueflux@koffein.net' =3D> 'Oskar Andreasson',
-'bmatheny@purdue.edu' =3D> 'Blake Matheny', # google
-'borisitk@fortunet.com' =3D> 'Boris Itkis', # by Kristian Peters
-'braam@clusterfs.com' =3D> 'Peter Braam',
-'brett@bad-sports.com' =3D> 'Brett Pemberton',
-'brihall@pcisys.net' =3D> 'Brian Hall', # google
-'brm@murphy.dk' =3D> 'Brian Murphy',
-'brownfld@irridia.com' =3D> 'Ken Brownfield',
-'bunk@fs.tum.de' =3D> 'Adrian Bunk',
-'buytenh@gnu.org' =3D> 'Lennert Buytenhek',
-'bwa@us.ibm.com' =3D> 'Bruce Allan',
-'bzeeb-lists@lists.zabbadoz.net' =3D> 'Bj=F6rn A. Zeeb', # lbdb
-'bzzz@tmi.comex.ru' =3D> 'Alex Tomas',
-'c-d.hailfinger.kernel.2002-07@gmx.net' =3D> 'Carl-Daniel Hailfinger',
-'c-d.hailfinger.kernel.2002-q4@gmx.net' =3D> 'Carl-Daniel Hailfinger', #=
 himself
-'cattelan@sgi.com' =3D> 'Russell Cattelan', # google
-'ccaputo@alt.net' =3D> 'Chris Caputo',
-'cel@citi.umich.edu' =3D> 'Chuck Lever',
-'celso@bulma.net' =3D> 'Celso Gonz=E1lez', # google
-'ch@hpl.hp.com' =3D> 'Christopher Hoover', # by Kristian Peters
-'charles.white@hp.com' =3D> 'Charles White',
-'chas@cmf.nrl.navy.mil' =3D> 'Chas Williams',
-'chas@locutus.cmf.nrl.navy.mil' =3D> 'Chas Williams',
-'chessman@tux.org' =3D> 'Samuel S. Chessman',
-'chris@qwirx.com' =3D> 'Chris Wilson',
-'chris@wirex.com' =3D> 'Chris Wright',
-'christer@weinigel.se' =3D> 'Christer Weinigel', # from shortlog
-'christopher.leech@intel.com' =3D> 'Christopher Leech',
-'cip307@cip.physik.uni-wuerzburg.de' =3D> 'Jochen Karrer', # from shortl=
og
-'ckulesa@as.arizona.edu' =3D> 'Craig Kulesa',
-'clemens@ladisch.de' =3D> 'Clemens Ladisch',
-'cloos@jhcloos.com' =3D> 'James H. Cloos Jr.',
-'cminyard@mvista.com' =3D> 'Corey Minyard',
-'cniehaus@handhelds.org' =3D> 'Carsten Niehaus',
-'cobra@compuserve.com' =3D> 'Kevin Brosius',
-'colin@gibbs.dhs.org' =3D> 'Colin Gibbs',
-'colpatch@us.ibm.com' =3D> 'Matthew Dobson',
-'corbet@lwn.net' =3D> 'Jonathan Corbet',
-'corryk@us.ibm.com' =3D> 'Kevin Corry',
-'cort@fsmlabs.com' =3D> 'Cort Dougan',
-'coughlan@redhat.com' =3D> 'Tom Coughlan',
-'cph@zurich.ai.mit.edu' =3D> 'Chris Hanson',
-'cr@sap.com' =3D> 'Christoph Rohland',
-'cramerj@intel.com' =3D> 'Jeb J. Cramer',
-'cruault@724.com' =3D> 'Charles-Edouard Ruault',
-'ctindel@cup.hp.com' =3D> 'Chad N. Tindel',
-'cubic@miee.ru' =3D> 'Ruslan U. Zakirov',
-'cw@f00f.org' =3D> 'Chris Wedgwood',
-'cwf@sgi.com' =3D> 'Charles Fumuso',
-'cyeoh@samba.org' =3D> 'Christopher Yeoh',
-'d.mueller@elsoft.ch' =3D> 'David M=FCller',
-'d3august@dtek.chalmers.se' =3D> 'Bj=F6rn Augustsson',
-'da-x@gmx.net' =3D> 'Dan Aloni',
-'daisy@teetime.dynamic.austin.ibm.com' =3D> 'Daisy Chang', # from shortl=
og
-'dale.farnsworth@mvista.com' =3D> 'Dale Farnsworth',
-'dale@farnsworth.org' =3D> 'Dale Farnsworth',
-'dalecki@evision-ventures.com' =3D> 'Martin Dalecki',
-'dalecki@evision.ag' =3D> 'Martin Dalecki',
-'dan.zink@hp.com' =3D> 'Dan Zink',
-'dan@debian.org' =3D> 'Daniel Jacobowitz',
-'dana.lacoste@peregrine.com' =3D> 'Dana Lacoste',
-'danc@mvista.com' =3D> 'Dan Cox', # some CREDITS patch found by google
-'daniel.ritz@gmx.ch' =3D> 'Daniel Ritz',
-'dave@qix.net' =3D> 'Dave Maietta',
-'dave@thedillows.org' =3D> 'David Dillow',
-'davej@codemonkey.or' =3D> 'Dave Jones',
-'davej@codemonkey.org.u' =3D> 'Dave Jones',
-'davej@codemonkey.org.uk' =3D> 'Dave Jones',
-'davej@suse.de' =3D> 'Dave Jones',
-'davej@tetrachloride.(none)' =3D> 'Dave Jones',
-'davem@hera.kernel.org' =3D> 'David S. Miller',
-'davem@kernel.bkbits.net' =3D> 'David S. Miller',
-'davem@nuts.ninka.net' =3D> 'David S. Miller',
-'davem@pizda.ninka.net' =3D> 'David S. Miller', # guessed
-'davem@redhat.com' =3D> 'David S. Miller',
-'david-b@pacbell.net' =3D> 'David Brownell',
-'david.nelson@pobox.com' =3D> 'David Nelson',
-'david@gibson.dropbear.id.au' =3D> 'David Gibson',
-'david_jeffery@adaptec.com' =3D> 'David Jeffery',
-'davidel@xmailserver.org' =3D> 'Davide Libenzi',
-'davidm@hpl.hp.com' =3D> 'David Mosberger',
-'davidm@napali.hpl.hp.com' =3D> 'David Mosberger',
-'davidm@tiger.hpl.hp.com' =3D> 'David Mosberger',
-'davidm@wailua.hpl.hp.com' =3D> 'David Mosberger',
-'davids@youknow.youwant.to' =3D> 'David Schwartz', # google
-'dbrownell@users.sourceforge.net' =3D> 'David Brownell',
-'ddstreet@ieee.org' =3D> 'Dan Streetman',
-'ddstreet@us.ibm.com' =3D> 'Dan Streetman',
-'defouwj@purdue.edu' =3D> 'Jeff DeFouw',
-'dent@cosy.sbg.ac.at' =3D> "Thomas 'Dent' Mirlacher",
-'devel@brodo.de' =3D> 'Dominik Brodowski',
-'devik@cdi.cz' =3D> 'Martin Devera',
-'dgibson@samba.org' =3D> 'David Gibson',
-'dhinds@sonic.net' =3D> 'David Hinds', # google
-'dhollis@davehollis.com' =3D> 'Dave Hollis',
-'dhowells@cambridge.redhat.com' =3D> 'David Howells',
-'dhowells@redhat.com' =3D> 'David Howells',
-'dipankar@in.ibm.com' =3D> 'Dipankar Sarma',
-'dirk.uffmann@nokia.com' =3D> 'Dirk Uffmann',
-'dledford@aladin.rdu.redhat.com' =3D> 'Doug Ledford',
-'dledford@dledford.theledfords.org' =3D> 'Doug Ledford',
-'dledford@flossy.devel.redhat.com' =3D> 'Doug Ledford',
-'dledford@redhat.com' =3D> 'Doug Ledford',
-'dlstevens@us.ibm.com' =3D> 'David Stevens',
-'dmccr@us.ibm.com' =3D> 'Dave McCracken',
-'dok@directfb.org' =3D> 'Denis Oliver Kropp',
-'dougg@torque.net' =3D> 'Douglas Gilbert',
-'drepper@redhat.com' =3D> 'Ulrich Drepper',
-'driver@huey.jpl.nasa.gov' =3D> 'Bryan B. Whitehead', # google
-'drow@false.org' =3D> 'Daniel Jacobowitz',
-'drow@nevyn.them.org' =3D> 'Daniel Jacobowitz',
-'dsaxena@mvista.com' =3D> 'Deepak Saxena',
-'duncan.sands@math.u-psud.fr' =3D> 'Duncan Sands',
-'dwmw2@dwmw2.baythorne.internal' =3D> 'David Woodhouse',
-'dwmw2@infradead.org' =3D> 'David Woodhouse',
-'dwmw2@redhat.com' =3D> 'David Woodhouse',
-'dz@cs.unitn.it' =3D> 'Massimo Dal Zotto',
-'ebiederm@xmission.com' =3D> 'Eric Biederman',
-'ebrower@resilience.com' =3D> 'Eric Brower',
-'ebrower@usa.net' =3D> 'Eric Brower',
-'ecd@skynet.be' =3D> 'Eddie C. Dost',
-'edv@macrolink.com' =3D> 'Ed Vance',
-'edward_peng@dlink.com.tw' =3D> 'Edward Peng',
-'efocht@ess.nec.de' =3D> 'Erich Focht',
-'eike-kernel@sf-tec.de' =3D> 'Rolf Eike Beer', # sent by himself
-'eike@bilbo.math.uni-mannheim.de' =3D> 'Rolf Eike Beer',
-'elenstev@mesatop.com' =3D> 'Steven Cole',
-'engebret@us.ibm.com' =3D> 'Dave Engebretsen',
-'eranian@frankl.hpl.hp.com' =3D> 'St=E9phane Eranian',
-'eranian@hpl.hp.com' =3D> 'St=E9phane Eranian',
-'erik@aarg.net' =3D> 'Erik Arneson',
-'erik_habbinga@hp.com' =3D> 'Erik Habbinga',
-'eyal@eyal.emu.id.au' =3D> 'Eyal Lebedinsky', # lbdb
-'falk.hueffner@student.uni-tuebingen.de' =3D> 'Falk Hueffner',
-'faikuygur@ttnet.net.tr' =3D> 'Faik Uygur',
-'fbl@conectiva.com.br' =3D> 'Fl=E1vio Bruno Leitner', # google
-'fdavis@si.rr.com' =3D> 'Frank Davis',
-'felipewd@terra.com.br' =3D> 'Felipe Damasio', # by self (did not ask to=
 include the W.)
-'fenghua.yu@intel.com' =3D> 'Fenghua Yu', # google
-'fero@sztalker.hu' =3D> 'Bakonyi Ferenc',
-'filip.sneppe@cronos.be' =3D> 'Filip Sneppe',
-'fischer@linux-buechse.de' =3D> 'J=FCrgen E. Fischer',
-'fletch@aracnet.com' =3D> 'Martin J. Bligh',
-'flo@rfc822.org' =3D> 'Florian Lohoff',
-'florian.thiel@gmx.net' =3D> 'Florian Thiel', # from shortlog
-'fnm@fusion.ukrsat.com' =3D> 'Nick Fedchik',
-'focht@ess.nec.de' =3D> 'Erich Focht',
-'fokkensr@fokkensr.vertis.nl' =3D> 'Rolf Fokkens',
-'franz.sirl-kernel@lauterbach.com' =3D> 'Franz Sirl',
-'franz.sirl@lauterbach.com' =3D> 'Franz Sirl',
-'fscked@netvisao.pt' =3D> 'Paulo Andr=E9',
-'fubar@us.ibm.com' =3D> 'Jay Vosburgh',
-'fw@deneb.enyo.de' =3D> 'Florian Weimer', # lbdb
-'fzago@austin.rr.com' =3D> 'Frank Zago', # google
-'ganadist@nakyup.mizi.com' =3D> 'Cha Young-Ho',
-'gandalf@wlug.westbo.se' =3D> 'Martin Josefsson',
-'ganesh@tuxtop.vxindia.veritas.com' =3D> 'Ganesh Varadarajan',
-'ganesh@veritas.com' =3D> 'Ganesh Varadarajan',
-'ganesh@vxindia.veritas.com' =3D> 'Ganesh Varadarajan',
-'garloff@suse.de' =3D> 'Kurt Garloff',
-'geert@linux-m68k.org' =3D> 'Geert Uytterhoeven',
-'george@mvista.com' =3D> 'George Anzinger',
-'georgn@somanetworks.com' =3D> 'Georg Nikodym',
-'gerg@moreton.com.au' =3D> 'Greg Ungerer',
-'gerg@snapgear.com' =3D> 'Greg Ungerer',
-'ghoz@sympatico.ca' =3D> 'Ghozlane Toumi',
-'gibbs@overdrive.btc.adaptec.com' =3D> 'Justin T. Gibbs',
-'gibbs@scsiguy.com' =3D> 'Justin T. Gibbs',
-'gilbertd@treblig.org' =3D> 'Dr. David Alan Gilbert',
-'gl@dsa-ac.de' =3D> 'Guennadi Liakhovetski',
-'glee@gnupilgrims.org' =3D> 'Geoffrey Lee', # lbdb
-'gnb@alphalink.com.au' =3D> 'Greg Banks',
-'go@turbolinux.co.jp' =3D> 'Go Taniguchi',
-'gone@us.ibm.com' =3D> 'Patricia Guaghen',
-'gotom@debian.or.jp' =3D> 'Goto Masanori', # from shortlog
-'gphat@cafes.net' =3D> 'Cory Watson',
-'greearb@candelatech.com' =3D> 'Ben Greear',
-'green@angband.namesys.com' =3D> 'Oleg Drokin',
-'green@linuxhacker.ru' =3D> 'Oleg Drokin',
-'green@namesys.com' =3D> 'Oleg Drokin',
-'greg@kroah.com' =3D> 'Greg Kroah-Hartman',
-'gregkh@kernel.bkbits.net' =3D> 'Greg Kroah-Hartman',
-'gronkin@nerdvana.com' =3D> 'George Ronkin',
-'grundler@cup.hp.com' =3D> 'Grant Grundler',
-'grundym@us.ibm.com' =3D> 'Michael Grundy',
-'gsromero@alumnos.euitt.upm.es' =3D> 'Guillermo S. Romero',
-'gtoumi@laposte.net' =3D> 'Ghozlane Toumi',
-'gwehrman@sgi.com' =3D> 'Geoffrey Wehrman',
-'hadi@cyberus.ca' =3D> 'Jamal Hadi Salim',
-'hannal@us.ibm.com' =3D> 'Hanna Linder',
-'harald@gnumonks.org' =3D> 'Harald Welte',
-'haveblue@us.ibm.com' =3D> 'Dave Hansen',
-'hch@caldera.de' =3D> 'Christoph Hellwig',
-'hch@dhcp212.munich.sgi.com' =3D> 'Christoph Hellwig',
-'hch@hera.kernel.org' =3D> 'Christoph Hellwig',
-'hch@infradead.org' =3D> 'Christoph Hellwig',
-'hch@lab343.munich.sgi.com' =3D> 'Christoph Hellwig',
-'hch@lst.de' =3D> 'Christoph Hellwig',
-'hch@pentafluge.infradead.org' =3D> 'Christoph Hellwig',
-'hch@sb.bsdonline.org' =3D> 'Christoph Hellwig', # by Kristian Peters
-'hch@sgi.com' =3D> 'Christoph Hellwig',
-'helgaas@fc.hp.com' =3D> 'Bjorn Helgaas', # doesn't want =F8/=E5
-'henning@meier-geinitz.de' =3D> 'Henning Meier-Geinitz',
-'henrique2.gobbi@cyclades.com' =3D> 'Henrique Gobbi',
-'henrique@cyclades.com' =3D> 'Henrique Gobbi',
-'hermes@gibson.dropbear.id.au' =3D> 'David Gibson',
-'hirofumi@mail.parknet.co.jp' =3D> 'Hirofumi Ogawa', # corrected by hims=
elf
-'hoho@binbash.net' =3D> 'Colin Slater',
-'hpa@transmeta.com' =3D> 'H. Peter Anvin',
-'hpa@zytor.com' =3D> 'H. Peter Anvin',
-'hugh@veritas.com' =3D> 'Hugh Dickins',
-'ica2_ts@csv.ica.uni-stuttgart.de' =3D> 'Thiemo Seufer', # google
-'info@usblcd.de' =3D>  'Adams IT Services',
-'ink@jurassic.park.msu.ru' =3D> 'Ivan Kokshaysky',
-'ink@ru.rmk.(none)' =3D> 'Ivan Kokshaysky',
-'ink@undisclosed.(none)' =3D> 'Ivan Kokshaysky',
-'ionut@badula.org' =3D> 'Ion Badulescu',
-'ionut@cs.columbia.edu' =3D> 'Ion Badulescu',
-'ioshadij@hotmail.com' =3D> 'Ishan O. Jayawardena',
-'irohlfs@irohlfs.de' =3D> 'Ingo Rohlfs',
-'ishikawa@linux.or.jp' =3D> 'Ishikawa Mutsumi',
-'ivangurdiev@linuxfreemail.com' =3D> 'Ivan Gyurdiev',
-'j-nomura@ce.jp.nec.com' =3D> 'Jun\'ichi Nomura',
-'jack@suse.cz' =3D> 'Jan Kara',
-'jack_hammer@adaptec.com' =3D> 'Jack Hammer',
-'jaharkes@cs.cmu.edu' =3D> 'Jan Harkes',
-'jakob.kemi@telia.com' =3D> 'Jakob Kemi',
-'jakub@redhat.com' =3D> 'Jakub Jel=EDnek',
-'jamagallon@able.es' =3D> 'J. A. Magallon',
-'james.bottomley@steeleye.com' =3D> 'James Bottomley',
-'james@cobaltmountain.com' =3D> 'James Mayer',
-'james_mcmechan@hotmail.com' =3D> 'James McMechan',
-'jamey.hicks@hp.com' =3D> 'Jamey Hicks',
-'jamey@crl.dec.com' =3D> 'Jamey Hicks',
-'jamie@shareable.org' =3D> 'Jamie Lokier',
-'jani@astechnix.ro' =3D> 'Jani Monoses',
-'jani@iv.ro' =3D> 'Jani Monoses',
-'jb@jblache.org' =3D> 'Julien Blache',
-'jbarnes@sgi.com' =3D> 'Jesse Barnes',
-'jbglaw@lug-owl.de' =3D> 'Jan-Benedict Glaw',
-'jblack@linuxguru.net' =3D> 'James Blackwell',
-'jdavid@farfalle.com' =3D> 'David Ruggiero',
-'jdike@jdike.wstearns.org' =3D> 'Jeff Dike',
-'jdike@karaya.com' =3D> 'Jeff Dike',
-'jdike@uml.karaya.com' =3D> 'Jeff Dike',
-'jdr@farfalle.com' =3D> 'David Ruggiero',
-'jdthood@yahoo.co.uk' =3D> 'Thomas Hood',
-'jeb.j.cramer@intel.com' =3D> 'Jeb J. Cramer',
-'jeff.wiedemeier@hp.com' =3D> 'Jeff Wiedemeier',
-'jeffs@accelent.com' =3D> 'Jeff Sutherland', # lbdb
-'jejb@malley.(none)' =3D> 'James Bottomley',
-'jejb@mulgrave.(none)' =3D> 'James Bottomley', # from shortlog
-'jejb@raven.il.steeleye.com' =3D> 'James Bottomley',
-'jenna.s.hall@intel.com' =3D> 'Jenna S. Hall', # google
-'jes@trained-monkey.org' =3D> 'Jes Sorensen',
-'jes@wildopensource.com' =3D> 'Jes Sorensen',
-'jgarzik@fokker2.devel.redhat.com' =3D> 'Jeff Garzik',
-'jgarzik@mandrakesoft.com' =3D> 'Jeff Garzik',
-'jgarzik@pobox.com' =3D> 'Jeff Garzik',
-'jgarzik@redhat.com' =3D> 'Jeff Garzik',
-'jgarzik@rum.normnet.org' =3D> 'Jeff Garzik',
-'jgarzik@tout.normnet.org' =3D> 'Jeff Garzik',
-'jgrimm2@us.ibm.com' =3D> 'Jon Grimm',
-'jgrimm@jgrimm.austin.ibm.com' =3D> 'Jon Grimm', # google
-'jgrimm@touki.austin.ibm.com' =3D> 'Jon Grimm', # google
-'jgrimm@touki.qip.austin.ibm.com' =3D> 'Jon Grimm', # google
-'jh@sgi.com' =3D> 'John Hesterberg',
-'jhammer@us.ibm.com' =3D> 'Jack Hammer',
-'jkt@helius.com' =3D> 'Jack Thomasson',
-'jmcmullan@linuxcare.com' =3D> 'Jason McMullan',
-'jmorris@intercode.com.au' =3D> 'James Morris',
-'jmorros@intercode.com.au' =3D> 'James Morris',	# it's typo IMHO
-'jo-lkml@suckfuell.net' =3D> 'Jochen Suckfuell',
-'jochen@jochen.org' =3D> 'Jochen Hein',
-'jochen@scram.de' =3D> 'Jochen Friedrich',
-'joe@fib011235813.fsnet.co.uk' =3D> 'Joe Thornber',
-'joe@wavicle.org' =3D> 'Joe Burks',
-'joel.buckley@sun.com' =3D> 'Joel Buckley',
-'joergprante@netcologne.de' =3D> 'J=F6rg Prante',
-'johann.deneux@it.uu.se' =3D> 'Johann Deneux',
-'johannes@erdfelt.com' =3D> 'Johannes Erdfelt',
-'john@deater.net' =3D> 'John Clemens',
-'john@grabjohn.com' =3D> 'John Bradford',
-'john@larvalstage.com' =3D> 'John Kim',
-'johnpol@2ka.mipt.ru' =3D> 'Evgeniy Polyakov',
-'johnstul@us.ibm.com' =3D> 'John Stultz',
-'josh@joshisanerd.com' =3D> 'Josh Myer',
-'jsiemes@web.de' =3D> 'Josef Siemes',
-'jsimmons@heisenberg.transvirtual.com' =3D> 'James Simmons',
-'jsimmons@infradead.org' =3D> 'James Simmons',
-'jsimmons@kozmo.(none)' =3D> 'James Simmons',
-'jsimmons@maxwell.earthlink.net' =3D> 'James Simmons',
-'jsimmons@transvirtual.com' =3D> 'James Simmons',
-'jsm@udlkern.fc.hp.com' =3D> 'John Marvin',
-'jt@bougret.hpl.hp.com' =3D> 'Jean Tourrilhes',
-'jt@hpl.hp.com' =3D> 'Jean Tourrilhes',
-'jtyner@cs.ucr.edu' =3D> 'John Tyner',
-'jun.nakajima@intel.com' =3D> 'Jun Nakajima',
-'jung-ik.lee@intel.com' =3D> 'J.I. Lee',
-'jwoithe@physics.adelaide.edu.au' =3D> 'Jonathan Woithe',
-'k-suganuma@mvj.biglobe.ne.jp' =3D> 'Kimio Suganuma',
-'k.kasprzak@box43.pl' =3D> 'Karol Kasprzak', # by Kristian Peters
-'kaber@trash.net' =3D> 'Patrick McHardy',
-'kadlec@blackhole.kfki.hu' =3D> 'Jozsef Kadlecsik',
-'kai-germaschewski@uiowa.edu' =3D> 'Kai Germaschewski',
-'kai.makisara@kolumbus.fi' =3D> 'Kai Makisara',
-'kai.reichert@udo.edu' =3D> 'Kai Reichert',
-'kai@chaos.tp1.ruhr-uni-bochum.de' =3D> 'Kai Germaschewski',
-'kai@tp1.ruhr-uni-bochum.de' =3D> 'Kai Germaschewski',
-'kai@vaio.(none)' =3D> 'Kai Germaschewski',
-'kala@pinerecords.com' =3D> 'Tomas Szepe',
-'kanoj@vger.kernel.org' =3D> 'Kanoj Sarcar', # sent by Arnaldo Carvalho =
de Melo
-'kanojsarcar@yahoo.com' =3D> 'Kanoj Sarcar',
-'kaos@ocs.com.au' =3D> 'Keith Owens',
-'kaos@sgi.com' =3D> 'Keith Owens', # sent by himself
-'kare.sars@lmf.ericsson.se' =3D> 'K=E5re S=E4rs',
-'kasperd@daimi.au.dk' =3D> 'Kasper Dupont',
-'keithu@parl.clemson.edu' =3D> 'Keith Underwood',
-'kenneth.w.chen@intel.com' =3D> 'Kenneth W. Chen',
-'kernel@jsl.com' =3D> 'Jeffrey S. Laing',
-'kernel@steeleye.com' =3D> 'Paul Clements',
-'key@austin.ibm.com' =3D> 'Kent Yoder',
-'khaho@koti.soon.fi' =3D> 'Ari Juhani H=E4meenaho',
-'khalid@fc.hp.com' =3D> 'Khalid Aziz',
-'khalid_aziz@hp.com' =3D> 'Khalid Aziz',
-'khc@pm.waw.pl' =3D> 'Krzysztof Halasa',
-'kiran@in.ibm.com' =3D> 'Ravikiran G. Thirumalai',
-'kisza@sch.bme.hu' =3D> 'Andras Kis-Szabo', # google (netfilter-ext HOWT=
O)
-'kkeil@suse.de' =3D> 'Karsten Keil',
-'kmsmith@umich.edu' =3D> 'Kendrick M. Smith',
-'knan@mo.himolde.no' =3D> 'Erik Inge Bols=F8',
-'kochi@hpc.bs1.fc.nec.co.jp' =3D> 'Kochi Takayoshi',
-'komujun@nifty.com' =3D> 'Jun Komuro', # google
-'kraxel@bytesex.org' =3D> 'Gerd Knorr',
-'kraxel@suse.de' =3D> 'Gerd Knorr',
-'krkumar@us.ibm.com' =3D> 'Krishna Kumar',
-'kronos@kronoz.cjb.net' =3D> 'Luca Tettamanti',
-'kuba@mareimbrium.org' =3D> 'Kuba Ober',
-'kuebelr@email.uc.edu' =3D> 'Robert Kuebel',
-'kunihiro@ipinfusion.com' =3D> 'Kunihiro Ishiguro',
-'kuznet@mops.inr.ac.ru' =3D> 'Alexey Kuznetsov',
-'kuznet@ms2.inr.ac.ru' =3D> 'Alexey Kuznetsov',
-'ladis@psi.cz' =3D> 'Ladislav Michl',
-'laforge@gnumonks.org' =3D> 'Harald Welte',
-'laforge@netfilter.org' =3D> 'Harald Welte',
-'latten@austin.ibm.com' =3D> 'Joy Latten',
-'laurent@latil.nom.fr' =3D> 'Laurent Latil',
-'lawrence@the-penguin.otak.com' =3D> 'Lawrence Walton',
-'ldb@ldb.ods.org' =3D> 'Luca Barbieri',
-'ldm@flatcap.org' =3D> 'Richard Russon',
-'lee@compucrew.com' =3D> 'Lee Nash', # lbdb
-'leigh@solinno.co.uk' =3D> 'Leigh Brown', # lbdb
-'levon@movementarian.org' =3D> 'John Levon',
-'lfo@polyad.org' =3D> 'Luis F. Ortiz',
-'linux@brodo.de' =3D> 'Dominik Brodowski',
-'linux@hazard.jcu.cz' =3D> 'Jan Marek',
-'lionel.bouton@inet6.fr' =3D> 'Lionel Bouton',
-'lists@mdiehl.de' =3D> 'Martin Diehl',
-'liyang@nerv.cx' =3D> 'Liyang Hu',
-'lm@bitmover.com' =3D> 'Larry McVoy',
-'lord@sgi.com' =3D> 'Stephen Lord',
-'louis.zhuang@linux.co.intel.com' =3D> 'Louis Zhuang',
-'louisk@cse.unsw.edu.au' =3D> 'Louis Yu-Kiu Kwan',
-'lowekamp@cs.wm.edu' =3D> 'Bruce B. Lowekamp', # lbdb
-'luben@splentec.com' =3D> 'Luben Tuikov',
-'luc.vanoostenryck@easynet.be' =3D> 'Luc Van Oostenryck', # lbdb
-'lucasvr@terra.com.br' =3D> 'Lucas Correia Villa Real', # google
-'lunz@falooley.org' =3D> 'Jason Lunz',
-'m.c.p@wolk-project.de' =3D> 'Marc-Christian Petersen',
-'maalanen@ra.abo.fi' =3D> 'Marcus Alanen',
-'mac@melware.de' =3D> 'Armin Schindler',
-'macro@ds2.pg.gda.pl' =3D> 'Maciej W. Rozycki',
-'manand@us.ibm.com' =3D> 'Mala Anand',
-'maneesh@in.ibm.com' =3D> 'Maneesh Soni',
-'manfred@colorfullife.com' =3D> 'Manfred Spraul',
-'manik@cisco.com' =3D> 'Manik Raina',
-'manish@zambeel.com' =3D> 'Manish Lachwani',
-'mannthey@us.ibm.com' =3D> 'Keith Mannthey',
-'marc@mbsi.ca' =3D> 'Marc Boucher',
-'marcel@holtmann.org' =3D> 'Marcel Holtmann', # sent by himself
-'marcelo@conectiva.com.br' =3D> 'Marcelo Tosatti',
-'marcelo@freak.distro.conectiva' =3D> 'Marcelo Tosatti', # guessed
-'marcelo@plucky.distro.conectiva' =3D> 'Marcelo Tosatti',
-'marcus@ingate.com' =3D> 'Marcus Sundberg',
-'marekm@amelek.gda.pl' =3D> 'Marek Michalkiewicz',
-'mark@alpha.dyndns.org' =3D> 'Mark W. McClelland',
-'mark@hal9000.dyndns.org' =3D> 'Mark W. McClelland',
-'markh@osdl.org' =3D> 'Mark Haverkamp',
-'martin.bligh@us.ibm.com' =3D> 'Martin J. Bligh',
-'martin@bruli.net' =3D> 'Martin Brulisauer',
-'martin@meltin.net' =3D> 'Martin Schwenke',
-'mason@suse.com' =3D> 'Chris Mason',
-'matt_domsch@dell.com' =3D> 'Matt Domsch', # sent by himself
-'matthew@wil.cx' =3D> 'Matthew Wilcox',
-'matthias.andree@gmx.de' =3D> 'Matthias Andree', # added by himself
-'mauelshagen@sistina.com' =3D> 'Heinz J. Mauelshagen',
-'maxk@qualcomm.com' =3D> 'Maksim Krasnyanskiy',
-'maxk@viper.(none)' =3D> 'Maksim Krasnyanskiy', # from shortlog
-'maxk@viper.qualcomm.com' =3D> 'Maksim Krasnyanskiy',
-'mbligh@aracnet.com' =3D> 'Martin J. Bligh',
-'mcp@linux-systeme.de' =3D> 'Marc-Christian Petersen',
-'mdharm-scsi@one-eyed-alien.net' =3D> 'Matthew Dharm',
-'mdharm-usb@one-eyed-alien.net' =3D> 'Matthew Dharm',
-'mdharm@one-eyed-alien.net' =3D> 'Matthew Dharm',
-'mec@shout.net' =3D> 'Michael Elizabeth Chastain',
-'meissner@suse.de' =3D> 'Marcus Meissner',
-'mgreer@mvista.com' =3D> 'Mark A. Greer', # lbdb
-'michaelw@foldr.org' =3D> 'Michael Weber', # google
-'michal@harddata.com' =3D> 'Michal Jaegermann',
-'mikael.starvik@axis.com' =3D> 'Mikael Starvik',
-'mikal@stillhq.com' =3D> 'Michael Still',
-'mike@aiinc.ca' =3D> 'Michael Hayes',
-'mikep@linuxtr.net' =3D> 'Mike Phillips',
-'mikpe@csd.uu.se' =3D> 'Mikael Pettersson',
-'mikpe@user.it.uu.se' =3D> 'Mikael Pettersson',
-'mikulas@artax.karlin.mff.cuni.cz' =3D> 'Mikulas Patocka',
-'miles@lsi.nec.co.jp' =3D> 'Miles Bader',
-'miles@megapathdsl.net' =3D> 'Miles Lane',
-'milli@acmeps.com' =3D> 'Michael Milligan',
-'miltonm@bga.com' =3D> 'Milton Miller', # by Kristian Peters
-'mingo@elte.hu' =3D> 'Ingo Molnar',
-'mingo@redhat.com' =3D> 'Ingo Molnar',
-'miyazawa@linux-ipv6.org' =3D> 'Kazunori Miyazawa',
-'mj@ucw.cz' =3D> 'Martin Mares',
-'mk@linux-ipv6.org' =3D> 'Mitsuru Kanda',
-'mkp@mkp.net' =3D> 'Martin K. Petersen', # lbdb
-'mlang@delysid.org' =3D> 'Mario Lang', # google
-'mlindner@syskonnect.de' =3D> 'Mirko Lindner',
-'mlocke@mvista.com' =3D> 'Montavista Software, Inc.',
-'mmcclell@bigfoot.com' =3D> 'Mark McClelland',
-'mochel@geena.pdx.osdl.net' =3D> 'Patrick Mochel',
-'mochel@osdl.org' =3D> 'Patrick Mochel',
-'mochel@segfault.osdl.org' =3D> 'Patrick Mochel',
-'mostrows@speakeasy.net' =3D> 'Michal Ostrowski',
-'mporter@cox.net' =3D> 'Matt Porter',
-'msdemlei@cl.uni-heidelberg.de' =3D> 'Markus Demleitner',
-'msw@redhat.com' =3D> 'Matt Wilson',
-'mufasa@sis.com.tw' =3D> 'Mufasa Yang', # sent by himself
-'mulix@actcom.co.il' =3D> 'Muli Ben-Yehuda', # sent by himself
-'mulix@mulix.org' =3D> 'Muli Ben-Yehuda',
-'mw@microdata-pos.de' =3D> 'Michael Westermann',
-'mzyngier@freesurf.fr' =3D> 'Marc Zyngier',
-'n0ano@n0ano.com' =3D> 'Don Dugger',
-'nahshon@actcom.co.il' =3D> 'Itai Nahshon',
-'nathans@sgi.com' =3D> 'Nathan Scott',
-'neilb@cse.unsw.edu.au' =3D> 'Neil Brown',
-'neilt@slimy.greenend.org.uk' =3D> 'Neil Turton',
-'nemosoft@smcc.demon.nl' =3D> 'Nemosoft Unv.',
-'netfilter@interlinx.bc.ca' =3D> 'Brian J. Murrell',
-'nick.holloway@pyrites.org.uk' =3D> 'Nick Holloway',
-'nico@cam.org' =3D> 'Nicolas Pitre',
-'nicolas.aspert@epfl.ch' =3D> 'Nicolas Aspert',
-'nicolas.mailhot@laposte.net' =3D> 'Nicolas Mailhot',
-'nkbj@image.dk' =3D> 'Niels Kristian Bech Jensen',
-'nlaredo@transmeta.com' =3D> 'Nathan Laredo',
-'nmiell@attbi.com' =3D> 'Nicholas Miell',
-'nobita@t-online.de' =3D> 'Andreas Busch',
-'okir@suse.de' =3D> 'Olaf Kirch', # lbdb
-'olaf.dietsche#list.linux-kernel@t-online.de' =3D> 'Olaf Dietsche',
+'abraham:2d3d.co.za' =3D> 'Abraham van der Merwe',
+'abslucio:terra.com.br' =3D> 'Lucio Maciel',
+'ac9410:attbi.com' =3D> 'Albert Cranford',
+'acher:in.tum.de' =3D> 'Georg Acher',
+'achirica:ttd.net' =3D> 'Javier Achirica',
+'acme:brinquedo.oo.ps' =3D> 'Arnaldo Carvalho de Melo',
+'acme:conectiva.com.br' =3D> 'Arnaldo Carvalho de Melo',
+'acme:dhcp197.conectiva' =3D> 'Arnaldo Carvalho de Melo',
+'acurtis:onz.com' =3D> 'Allen Curtis',
+'adam:mailhost.nmt.edu' =3D> 'Adam Radford', # google
+'adam:nmt.edu' =3D> 'Adam Radford', # google
+'adam:yggdrasil.com' =3D> 'Adam J. Richter',
+'adaplas:pol.net' =3D> 'Antonino Daplas',
+'adilger:clusterfs.com' =3D> 'Andreas Dilger',
+'aebr:win.tue.nl' =3D> 'Andries E. Brouwer',
+'agrover:acpi3.(none)' =3D> 'Andy Grover',
+'agrover:acpi3.jf.intel.com' =3D> 'Andy Grover', # guessed
+'agrover:dexter.groveronline.com' =3D> 'Andy Grover',
+'agrover:groveronline.com' =3D> 'Andy Grover',
+'agruen:suse.de' =3D> 'Andreas Gruenbacher',
+'ahaas:airmail.net' =3D> 'Art Haas',
+'ahaas:neosoft.com' =3D> 'Art Haas',
+'aia21:cam.ac.uk' =3D> 'Anton Altaparmakov',
+'aia21:cantab.net' =3D> 'Anton Altaparmakov',
+'aia21:cus.cam.ac.uk' =3D> 'Anton Altaparmakov',
+'ajoshi:kernel.crashing.org' =3D> 'Ani Joshi',
+'ajoshi:shell.unixbox.com' =3D> 'Ani Joshi',
+'ak:muc.de' =3D> 'Andi Kleen',
+'ak:suse.de' =3D> 'Andi Kleen',
+'akpm:digeo.com' =3D> 'Andrew Morton',
+'akpm:zip.com.au' =3D> 'Andrew Morton',
+'akropel1:rochester.rr.com' =3D> 'Adam Kropelin', # lbdb
+'alan:lxorguk.ukuu.org.uk' =3D> 'Alan Cox',
+'alan:redhat.com' =3D> 'Alan Cox',
+'alex:ssi.bg' =3D> 'Alexander Atanasov',
+'alex_williamson:attbi.com' =3D> 'Alex Williamson', # lbdb
+'alex_williamson:hp.com' =3D> 'Alex Williamson', # google
+'alexander.riesen:synopsys.com' =3D> 'Alexander Riesen',
+'alexey:technomagesinc.com' =3D> 'Alex Tomas',
+'alfre:ibd.es' =3D> 'Alfredo Sanju=E1n',
+'ambx1:neo.rr.com' =3D> 'Adam Belay',
+'amunoz:vmware.com' =3D> 'Alberto Munoz',
+'andersen:codepoet.org' =3D> 'Erik Andersen',
+'andersg:0x63.nu' =3D> 'Anders Gustafsson',
+'andmike:us.ibm.com' =3D> 'Mike Anderson', # lbdb
+'andrea:suse.de' =3D> 'Andrea Arcangeli',
+'andrew.wood:ivarch.com' =3D> 'Andrew Wood',
+'andries.brouwer:cwi.nl' =3D> 'Andries E. Brouwer',
+'andros:citi.umich.edu' =3D> 'Andy Adamson',
+'andre.breiler:null-mx.org' =3D> 'Andr=E9 Breiler',
+'angus.sawyer:dsl.pipex.com' =3D> 'Angus Sawyer',
+'ankry:green.mif.pg.gda.pl' =3D> 'Andrzej Krzysztofowicz',
+'anton:samba.org' =3D> 'Anton Blanchard',
+'aris:cathedrallabs.org' =3D> 'Aristeu Sergio Rozanski Filho',
+'arjan:redhat.com' =3D> 'Arjan van de Ven',
+'arjanv:redhat.com' =3D> 'Arjan van de Ven',
+'arnd:arndb.de' =3D> 'Arnd Bergmann',
+'arnd:bergmann-dalldorf.de' =3D> 'Arnd Bergmann',
+'arndb:de.ibm.com' =3D> 'Arnd Bergmann',
+'arun.sharma:intel.com' =3D> 'Arun Sharma',
+'asit.k.mallick:intel.com' =3D> 'Asit K. Mallick', # by Kristian Peters
+'axboe:burns.home.kernel.dk' =3D> 'Jens Axboe', # guessed
+'axboe:hera.kernel.org' =3D> 'Jens Axboe',
+'axboe:suse.de' =3D> 'Jens Axboe',
+'azarah:gentoo.org' =3D> 'Martin Schlemmer',
+'baccala:vger.freesoft.org' =3D> 'Brent Baccala',
+'baldrick:wanadoo.fr' =3D> 'Duncan Sands',
+'ballabio_dario:emc.com' =3D> 'Dario Ballabio',
+'barrow_dj:yahoo.com' =3D> 'D. J. Barrow',
+'barryn:pobox.com' =3D> 'Barry K. Nathan', # lbdb
+'bart.de.schuymer:pandora.be' =3D> 'Bart De Schuymer',
+'bcollins:debian.org' =3D> 'Ben Collins',
+'bcrl:bob.home.kvack.org' =3D> 'Benjamin LaHaise',
+'bcrl:redhat.com' =3D> 'Benjamin LaHaise',
+'bcrl:toomuch.toronto.redhat.com' =3D> 'Benjamin LaHaise', # guessed
+'bde:bwlink.com' =3D> 'Bruce D. Elliott',	# it's typo IMHO
+'bde:nwlink.com' =3D> 'Bruce D. Elliott',
+'bdschuym:pandora.be' =3D> 'Bart De Schuymer',
+'beattie:beattie-home.net' =3D> 'Brian Beattie', # from david.nelson
+'benh:kernel.crashing.org' =3D> 'Benjamin Herrenschmidt',
+'benh:zion.wanadoo.fr' =3D> 'Benjamin Herrenschmidt',
+'bergner:vnet.ibm.com' =3D> 'Peter Bergner',
+'bero:arklinux.org' =3D> 'Bernhard Rosenkraenzer',
+'bfennema:falcon.csc.calpoly.edu' =3D> 'Ben Fennema',
+'bgerst:didntduck.org' =3D> 'Brian Gerst',
+'bhards:bigpond.net.au' =3D> 'Brad Hards',
+'bhavesh:avaya.com' =3D> 'Bhavesh P. Davda',
+'bheilbrun:paypal.com' =3D> 'Brad Heilbrun', # by himself
+'bjorn.andersson:erc.ericsson.se' =3D> 'Bj=F6rn Andersson', # google, gu=
essed =F6
+'bjorn.wesen:axis.com' =3D> 'Bjorn Wesen',
+'bjorn_helgaas:hp.com' =3D> 'Bjorn Helgaas',
+'blaschke:blaschke3.austin.ibm.com' =3D> 'Dave Blaschke',
+'blueflux:koffein.net' =3D> 'Oskar Andreasson',
+'bmatheny:purdue.edu' =3D> 'Blake Matheny', # google
+'borisitk:fortunet.com' =3D> 'Boris Itkis', # by Kristian Peters
+'braam:clusterfs.com' =3D> 'Peter Braam',
+'brett:bad-sports.com' =3D> 'Brett Pemberton',
+'brihall:pcisys.net' =3D> 'Brian Hall', # google
+'brm:murphy.dk' =3D> 'Brian Murphy',
+'brownfld:irridia.com' =3D> 'Ken Brownfield',
+'bunk:fs.tum.de' =3D> 'Adrian Bunk',
+'buytenh:gnu.org' =3D> 'Lennert Buytenhek',
+'bwa:us.ibm.com' =3D> 'Bruce Allan',
+'bwindle:fint.org' =3D> 'Burton N. Windle',
+'bzeeb-lists:lists.zabbadoz.net' =3D> 'Bj=F6rn A. Zeeb', # lbdb
+'bzzz:tmi.comex.ru' =3D> 'Alex Tomas',
+'c-d.hailfinger.kernel.2002-07:gmx.net' =3D> 'Carl-Daniel Hailfinger',
+'c-d.hailfinger.kernel.2002-q4:gmx.net' =3D> 'Carl-Daniel Hailfinger', #=
 himself
+'cattelan:sgi.com' =3D> 'Russell Cattelan', # google
+'ccaputo:alt.net' =3D> 'Chris Caputo',
+'cel:citi.umich.edu' =3D> 'Chuck Lever',
+'celso:bulma.net' =3D> 'Celso Gonz=E1lez', # google
+'ch:hpl.hp.com' =3D> 'Christopher Hoover', # by Kristian Peters
+'charles.white:hp.com' =3D> 'Charles White',
+'chas:cmf.nrl.navy.mil' =3D> 'Chas Williams',
+'chas:locutus.cmf.nrl.navy.mil' =3D> 'Chas Williams',
+'chessman:tux.org' =3D> 'Samuel S. Chessman',
+'chris:qwirx.com' =3D> 'Chris Wilson',
+'chris:wirex.com' =3D> 'Chris Wright',
+'christer:weinigel.se' =3D> 'Christer Weinigel', # from shortlog
+'christopher.leech:intel.com' =3D> 'Christopher Leech',
+'cip307:cip.physik.uni-wuerzburg.de' =3D> 'Jochen Karrer', # from shortl=
og
+'ckulesa:as.arizona.edu' =3D> 'Craig Kulesa',
+'clemens:ladisch.de' =3D> 'Clemens Ladisch',
+'cloos:jhcloos.com' =3D> 'James H. Cloos Jr.',
+'cminyard:mvista.com' =3D> 'Corey Minyard',
+'cniehaus:handhelds.org' =3D> 'Carsten Niehaus',
+'cobra:compuserve.com' =3D> 'Kevin Brosius',
+'colin:gibbs.dhs.org' =3D> 'Colin Gibbs',
+'colpatch:us.ibm.com' =3D> 'Matthew Dobson',
+'corbet:lwn.net' =3D> 'Jonathan Corbet',
+'corryk:us.ibm.com' =3D> 'Kevin Corry',
+'cort:fsmlabs.com' =3D> 'Cort Dougan',
+'coughlan:redhat.com' =3D> 'Tom Coughlan',
+'cph:zurich.ai.mit.edu' =3D> 'Chris Hanson',
+'cr:sap.com' =3D> 'Christoph Rohland',
+'cramerj:intel.com' =3D> 'Jeb J. Cramer',
+'cruault:724.com' =3D> 'Charles-Edouard Ruault',
+'ctindel:cup.hp.com' =3D> 'Chad N. Tindel',
+'cubic:miee.ru' =3D> 'Ruslan U. Zakirov',
+'cw:f00f.org' =3D> 'Chris Wedgwood',
+'cwf:sgi.com' =3D> 'Charles Fumuso',
+'cyeoh:samba.org' =3D> 'Christopher Yeoh',
+'d.mueller:elsoft.ch' =3D> 'David M=FCller',
+'d3august:dtek.chalmers.se' =3D> 'Bj=F6rn Augustsson',
+'da-x:gmx.net' =3D> 'Dan Aloni',
+'daisy:teetime.dynamic.austin.ibm.com' =3D> 'Daisy Chang', # from shortl=
og
+'dale.farnsworth:mvista.com' =3D> 'Dale Farnsworth',
+'dale:farnsworth.org' =3D> 'Dale Farnsworth',
+'dalecki:evision-ventures.com' =3D> 'Martin Dalecki',
+'dalecki:evision.ag' =3D> 'Martin Dalecki',
+'dan.zink:hp.com' =3D> 'Dan Zink',
+'dan:debian.org' =3D> 'Daniel Jacobowitz',
+'dana.lacoste:peregrine.com' =3D> 'Dana Lacoste',
+'danc:mvista.com' =3D> 'Dan Cox', # some CREDITS patch found by google
+'daniel.ritz:gmx.ch' =3D> 'Daniel Ritz',
+'dave:qix.net' =3D> 'Dave Maietta',
+'dave:thedillows.org' =3D> 'David Dillow',
+'davej:codemonkey.or' =3D> 'Dave Jones',
+'davej:codemonkey.org.u' =3D> 'Dave Jones',
+'davej:codemonkey.org.uk' =3D> 'Dave Jones',
+'davej:suse.de' =3D> 'Dave Jones',
+'davej:tetrachloride.(none)' =3D> 'Dave Jones',
+'davem:hera.kernel.org' =3D> 'David S. Miller',
+'davem:kernel.bkbits.net' =3D> 'David S. Miller',
+'davem:nuts.ninka.net' =3D> 'David S. Miller',
+'davem:pizda.ninka.net' =3D> 'David S. Miller', # guessed
+'davem:redhat.com' =3D> 'David S. Miller',
+'david-b:pacbell.net' =3D> 'David Brownell',
+'david.nelson:pobox.com' =3D> 'David Nelson',
+'david:gibson.dropbear.id.au' =3D> 'David Gibson',
+'david_jeffery:adaptec.com' =3D> 'David Jeffery',
+'davidel:xmailserver.org' =3D> 'Davide Libenzi',
+'davidm:hpl.hp.com' =3D> 'David Mosberger',
+'davidm:napali.hpl.hp.com' =3D> 'David Mosberger',
+'davidm:tiger.hpl.hp.com' =3D> 'David Mosberger',
+'davidm:wailua.hpl.hp.com' =3D> 'David Mosberger',
+'davids:youknow.youwant.to' =3D> 'David Schwartz', # google
+'dbrownell:users.sourceforge.net' =3D> 'David Brownell',
+'ddstreet:ieee.org' =3D> 'Dan Streetman',
+'ddstreet:us.ibm.com' =3D> 'Dan Streetman',
+'defouwj:purdue.edu' =3D> 'Jeff DeFouw',
+'dent:cosy.sbg.ac.at' =3D> "Thomas 'Dent' Mirlacher",
+'devel:brodo.de' =3D> 'Dominik Brodowski',
+'devik:cdi.cz' =3D> 'Martin Devera',
+'dgibson:samba.org' =3D> 'David Gibson',
+'dhinds:sonic.net' =3D> 'David Hinds', # google
+'dhollis:davehollis.com' =3D> 'Dave Hollis',
+'dhowells:cambridge.redhat.com' =3D> 'David Howells',
+'dhowells:redhat.com' =3D> 'David Howells',
+'dipankar:in.ibm.com' =3D> 'Dipankar Sarma',
+'dirk.uffmann:nokia.com' =3D> 'Dirk Uffmann',
+'dledford:aladin.rdu.redhat.com' =3D> 'Doug Ledford',
+'dledford:dledford.theledfords.org' =3D> 'Doug Ledford',
+'dledford:flossy.devel.redhat.com' =3D> 'Doug Ledford',
+'dledford:redhat.com' =3D> 'Doug Ledford',
+'dlstevens:us.ibm.com' =3D> 'David Stevens',
+'dmccr:us.ibm.com' =3D> 'Dave McCracken',
+'dok:directfb.org' =3D> 'Denis Oliver Kropp',
+'dougg:torque.net' =3D> 'Douglas Gilbert',
+'drepper:redhat.com' =3D> 'Ulrich Drepper',
+'driver:huey.jpl.nasa.gov' =3D> 'Bryan B. Whitehead', # google
+'drow:false.org' =3D> 'Daniel Jacobowitz',
+'drow:nevyn.them.org' =3D> 'Daniel Jacobowitz',
+'dsaxena:mvista.com' =3D> 'Deepak Saxena',
+'duncan.sands:math.u-psud.fr' =3D> 'Duncan Sands',
+'dwmw2:dwmw2.baythorne.internal' =3D> 'David Woodhouse',
+'dwmw2:infradead.org' =3D> 'David Woodhouse',
+'dwmw2:redhat.com' =3D> 'David Woodhouse',
+'dz:cs.unitn.it' =3D> 'Massimo Dal Zotto',
+'ebiederm:xmission.com' =3D> 'Eric Biederman',
+'ebrower:resilience.com' =3D> 'Eric Brower',
+'ebrower:usa.net' =3D> 'Eric Brower',
+'ecd:skynet.be' =3D> 'Eddie C. Dost',
+'edv:macrolink.com' =3D> 'Ed Vance',
+'edward_peng:dlink.com.tw' =3D> 'Edward Peng',
+'efocht:ess.nec.de' =3D> 'Erich Focht',
+'eike-kernel:sf-tec.de' =3D> 'Rolf Eike Beer', # sent by himself
+'eike:bilbo.math.uni-mannheim.de' =3D> 'Rolf Eike Beer',
+'elenstev:mesatop.com' =3D> 'Steven Cole',
+'engebret:us.ibm.com' =3D> 'Dave Engebretsen',
+'eranian:frankl.hpl.hp.com' =3D> 'St=E9phane Eranian',
+'eranian:hpl.hp.com' =3D> 'St=E9phane Eranian',
+'erik:aarg.net' =3D> 'Erik Arneson',
+'erik_habbinga:hp.com' =3D> 'Erik Habbinga',
+'eyal:eyal.emu.id.au' =3D> 'Eyal Lebedinsky', # lbdb
+'falk.hueffner:student.uni-tuebingen.de' =3D> 'Falk Hueffner',
+'faikuygur:ttnet.net.tr' =3D> 'Faik Uygur',
+'fbl:conectiva.com.br' =3D> 'Fl=E1vio Bruno Leitner', # google
+'fdavis:si.rr.com' =3D> 'Frank Davis',
+'felipewd:terra.com.br' =3D> 'Felipe Damasio', # by self (did not ask to=
 include the W.)
+'fenghua.yu:intel.com' =3D> 'Fenghua Yu', # google
+'fero:sztalker.hu' =3D> 'Bakonyi Ferenc',
+'filip.sneppe:cronos.be' =3D> 'Filip Sneppe',
+'fischer:linux-buechse.de' =3D> 'J=FCrgen E. Fischer',
+'fletch:aracnet.com' =3D> 'Martin J. Bligh',
+'flo:rfc822.org' =3D> 'Florian Lohoff',
+'florian.thiel:gmx.net' =3D> 'Florian Thiel', # from shortlog
+'fnm:fusion.ukrsat.com' =3D> 'Nick Fedchik',
+'focht:ess.nec.de' =3D> 'Erich Focht',
+'fokkensr:fokkensr.vertis.nl' =3D> 'Rolf Fokkens',
+'franz.sirl-kernel:lauterbach.com' =3D> 'Franz Sirl',
+'franz.sirl:lauterbach.com' =3D> 'Franz Sirl',
+'fscked:netvisao.pt' =3D> 'Paulo Andr=E9',
+'fubar:us.ibm.com' =3D> 'Jay Vosburgh',
+'fw:deneb.enyo.de' =3D> 'Florian Weimer', # lbdb
+'fzago:austin.rr.com' =3D> 'Frank Zago', # google
+'ganadist:nakyup.mizi.com' =3D> 'Cha Young-Ho',
+'gandalf:wlug.westbo.se' =3D> 'Martin Josefsson',
+'ganesh:tuxtop.vxindia.veritas.com' =3D> 'Ganesh Varadarajan',
+'ganesh:veritas.com' =3D> 'Ganesh Varadarajan',
+'ganesh:vxindia.veritas.com' =3D> 'Ganesh Varadarajan',
+'garloff:suse.de' =3D> 'Kurt Garloff',
+'geert:linux-m68k.org' =3D> 'Geert Uytterhoeven',
+'george:mvista.com' =3D> 'George Anzinger',
+'georgn:somanetworks.com' =3D> 'Georg Nikodym',
+'gerg:moreton.com.au' =3D> 'Greg Ungerer',
+'gerg:snapgear.com' =3D> 'Greg Ungerer',
+'ghoz:sympatico.ca' =3D> 'Ghozlane Toumi',
+'gibbs:overdrive.btc.adaptec.com' =3D> 'Justin T. Gibbs',
+'gibbs:scsiguy.com' =3D> 'Justin T. Gibbs',
+'gilbertd:treblig.org' =3D> 'Dr. David Alan Gilbert',
+'gl:dsa-ac.de' =3D> 'Guennadi Liakhovetski',
+'glee:gnupilgrims.org' =3D> 'Geoffrey Lee', # lbdb
+'gnb:alphalink.com.au' =3D> 'Greg Banks',
+'go:turbolinux.co.jp' =3D> 'Go Taniguchi',
+'gone:us.ibm.com' =3D> 'Patricia Guaghen',
+'gotom:debian.or.jp' =3D> 'Goto Masanori', # from shortlog
+'gphat:cafes.net' =3D> 'Cory Watson',
+'greearb:candelatech.com' =3D> 'Ben Greear',
+'green:angband.namesys.com' =3D> 'Oleg Drokin',
+'green:linuxhacker.ru' =3D> 'Oleg Drokin',
+'green:namesys.com' =3D> 'Oleg Drokin',
+'greg:kroah.com' =3D> 'Greg Kroah-Hartman',
+'gregkh:kernel.bkbits.net' =3D> 'Greg Kroah-Hartman',
+'gronkin:nerdvana.com' =3D> 'George Ronkin',
+'grundler:cup.hp.com' =3D> 'Grant Grundler',
+'grundym:us.ibm.com' =3D> 'Michael Grundy',
+'gsromero:alumnos.euitt.upm.es' =3D> 'Guillermo S. Romero',
+'gtoumi:laposte.net' =3D> 'Ghozlane Toumi',
+'gwehrman:sgi.com' =3D> 'Geoffrey Wehrman',
+'hadi:cyberus.ca' =3D> 'Jamal Hadi Salim',
+'hannal:us.ibm.com' =3D> 'Hanna Linder',
+'harald:gnumonks.org' =3D> 'Harald Welte',
+'haveblue:us.ibm.com' =3D> 'Dave Hansen',
+'hch:caldera.de' =3D> 'Christoph Hellwig',
+'hch:dhcp212.munich.sgi.com' =3D> 'Christoph Hellwig',
+'hch:hera.kernel.org' =3D> 'Christoph Hellwig',
+'hch:infradead.org' =3D> 'Christoph Hellwig',
+'hch:lab343.munich.sgi.com' =3D> 'Christoph Hellwig',
+'hch:lst.de' =3D> 'Christoph Hellwig',
+'hch:pentafluge.infradead.org' =3D> 'Christoph Hellwig',
+'hch:sb.bsdonline.org' =3D> 'Christoph Hellwig', # by Kristian Peters
+'hch:sgi.com' =3D> 'Christoph Hellwig',
+'helgaas:fc.hp.com' =3D> 'Bjorn Helgaas', # doesn't want =F8/=E5
+'henning:meier-geinitz.de' =3D> 'Henning Meier-Geinitz',
+'henrique2.gobbi:cyclades.com' =3D> 'Henrique Gobbi',
+'henrique:cyclades.com' =3D> 'Henrique Gobbi',
+'hermes:gibson.dropbear.id.au' =3D> 'David Gibson',
+'hirofumi:mail.parknet.co.jp' =3D> 'Hirofumi Ogawa', # corrected by hims=
elf
+'hoho:binbash.net' =3D> 'Colin Slater',
+'hpa:transmeta.com' =3D> 'H. Peter Anvin',
+'hpa:zytor.com' =3D> 'H. Peter Anvin',
+'hugh:veritas.com' =3D> 'Hugh Dickins',
+'ica2_ts:csv.ica.uni-stuttgart.de' =3D> 'Thiemo Seufer', # google
+'info:usblcd.de' =3D>  'Adams IT Services',
+'ink:jurassic.park.msu.ru' =3D> 'Ivan Kokshaysky',
+'ink:ru.rmk.(none)' =3D> 'Ivan Kokshaysky',
+'ink:undisclosed.(none)' =3D> 'Ivan Kokshaysky',
+'ionut:badula.org' =3D> 'Ion Badulescu',
+'ionut:cs.columbia.edu' =3D> 'Ion Badulescu',
+'ioshadij:hotmail.com' =3D> 'Ishan O. Jayawardena',
+'irohlfs:irohlfs.de' =3D> 'Ingo Rohlfs',
+'ishikawa:linux.or.jp' =3D> 'Ishikawa Mutsumi',
+'ivangurdiev:linuxfreemail.com' =3D> 'Ivan Gyurdiev',
+'j-nomura:ce.jp.nec.com' =3D> 'Jun\'ichi Nomura',
+'j.dittmer:portrix.net' =3D> 'Jan Dittmer',
+'jack:suse.cz' =3D> 'Jan Kara',
+'jack_hammer:adaptec.com' =3D> 'Jack Hammer',
+'jaharkes:cs.cmu.edu' =3D> 'Jan Harkes',
+'jakob.kemi:telia.com' =3D> 'Jakob Kemi',
+'jakub:redhat.com' =3D> 'Jakub Jel=EDnek',
+'jamagallon:able.es' =3D> 'J. A. Magallon',
+'james.bottomley:steeleye.com' =3D> 'James Bottomley',
+'james:cobaltmountain.com' =3D> 'James Mayer',
+'james_mcmechan:hotmail.com' =3D> 'James McMechan',
+'jamey.hicks:hp.com' =3D> 'Jamey Hicks',
+'jamey:crl.dec.com' =3D> 'Jamey Hicks',
+'jamie:shareable.org' =3D> 'Jamie Lokier',
+'jani:astechnix.ro' =3D> 'Jani Monoses',
+'jani:iv.ro' =3D> 'Jani Monoses',
+'jb:jblache.org' =3D> 'Julien Blache',
+'jbarnes:sgi.com' =3D> 'Jesse Barnes',
+'jbglaw:lug-owl.de' =3D> 'Jan-Benedict Glaw',
+'jblack:linuxguru.net' =3D> 'James Blackwell',
+'jdavid:farfalle.com' =3D> 'David Ruggiero',
+'jdike:jdike.wstearns.org' =3D> 'Jeff Dike',
+'jdike:karaya.com' =3D> 'Jeff Dike',
+'jdike:uml.karaya.com' =3D> 'Jeff Dike',
+'jdr:farfalle.com' =3D> 'David Ruggiero',
+'jdthood:yahoo.co.uk' =3D> 'Thomas Hood',
+'jeb.j.cramer:intel.com' =3D> 'Jeb J. Cramer',
+'jeff.wiedemeier:hp.com' =3D> 'Jeff Wiedemeier',
+'jeffs:accelent.com' =3D> 'Jeff Sutherland', # lbdb
+'jejb:malley.(none)' =3D> 'James Bottomley',
+'jejb:mulgrave.(none)' =3D> 'James Bottomley', # from shortlog
+'jejb:raven.il.steeleye.com' =3D> 'James Bottomley',
+'jenna.s.hall:intel.com' =3D> 'Jenna S. Hall', # google
+'jes:trained-monkey.org' =3D> 'Jes Sorensen',
+'jes:wildopensource.com' =3D> 'Jes Sorensen',
+'jgarzik:fokker2.devel.redhat.com' =3D> 'Jeff Garzik',
+'jgarzik:mandrakesoft.com' =3D> 'Jeff Garzik',
+'jgarzik:pobox.com' =3D> 'Jeff Garzik',
+'jgarzik:redhat.com' =3D> 'Jeff Garzik',
+'jgarzik:rum.normnet.org' =3D> 'Jeff Garzik',
+'jgarzik:tout.normnet.org' =3D> 'Jeff Garzik',
+'jgrimm2:us.ibm.com' =3D> 'Jon Grimm',
+'jgrimm:jgrimm.austin.ibm.com' =3D> 'Jon Grimm', # google
+'jgrimm:touki.austin.ibm.com' =3D> 'Jon Grimm', # google
+'jgrimm:touki.qip.austin.ibm.com' =3D> 'Jon Grimm', # google
+'jh:sgi.com' =3D> 'John Hesterberg',
+'jhammer:us.ibm.com' =3D> 'Jack Hammer',
+'jkt:helius.com' =3D> 'Jack Thomasson',
+'jmcmullan:linuxcare.com' =3D> 'Jason McMullan',
+'jmorris:intercode.com.au' =3D> 'James Morris',
+'jmorros:intercode.com.au' =3D> 'James Morris',	# it's typo IMHO
+'jo-lkml:suckfuell.net' =3D> 'Jochen Suckfuell',
+'jochen:jochen.org' =3D> 'Jochen Hein',
+'jochen:scram.de' =3D> 'Jochen Friedrich',
+'joe:fib011235813.fsnet.co.uk' =3D> 'Joe Thornber',
+'joe:perches.com' =3D> 'Joe Perches',
+'joe:wavicle.org' =3D> 'Joe Burks',
+'joel.buckley:sun.com' =3D> 'Joel Buckley',
+'joergprante:netcologne.de' =3D> 'J=F6rg Prante',
+'johann.deneux:it.uu.se' =3D> 'Johann Deneux',
+'johannes:erdfelt.com' =3D> 'Johannes Erdfelt',
+'john:deater.net' =3D> 'John Clemens',
+'john:grabjohn.com' =3D> 'John Bradford',
+'john:larvalstage.com' =3D> 'John Kim',
+'johnpol:2ka.mipt.ru' =3D> 'Evgeniy Polyakov',
+'johnstul:us.ibm.com' =3D> 'John Stultz',
+'josh:joshisanerd.com' =3D> 'Josh Myer',
+'jsiemes:web.de' =3D> 'Josef Siemes',
+'jsimmons:heisenberg.transvirtual.com' =3D> 'James Simmons',
+'jsimmons:infradead.org' =3D> 'James Simmons',
+'jsimmons:kozmo.(none)' =3D> 'James Simmons',
+'jsimmons:maxwell.earthlink.net' =3D> 'James Simmons',
+'jsimmons:transvirtual.com' =3D> 'James Simmons',
+'jsm:udlkern.fc.hp.com' =3D> 'John Marvin',
+'jt:bougret.hpl.hp.com' =3D> 'Jean Tourrilhes',
+'jt:hpl.hp.com' =3D> 'Jean Tourrilhes',
+'jtyner:cs.ucr.edu' =3D> 'John Tyner',
+'jun.nakajima:intel.com' =3D> 'Jun Nakajima',
+'jung-ik.lee:intel.com' =3D> 'J.I. Lee',
+'jwoithe:physics.adelaide.edu.au' =3D> 'Jonathan Woithe',
+'k-suganuma:mvj.biglobe.ne.jp' =3D> 'Kimio Suganuma',
+'k.kasprzak:box43.pl' =3D> 'Karol Kasprzak', # by Kristian Peters
+'kaber:trash.net' =3D> 'Patrick McHardy',
+'kadlec:blackhole.kfki.hu' =3D> 'Jozsef Kadlecsik',
+'kai-germaschewski:uiowa.edu' =3D> 'Kai Germaschewski',
+'kai.makisara:kolumbus.fi' =3D> 'Kai Makisara',
+'kai.reichert:udo.edu' =3D> 'Kai Reichert',
+'kai:chaos.tp1.ruhr-uni-bochum.de' =3D> 'Kai Germaschewski',
+'kai:tp1.ruhr-uni-bochum.de' =3D> 'Kai Germaschewski',
+'kai:vaio.(none)' =3D> 'Kai Germaschewski',
+'kala:pinerecords.com' =3D> 'Tomas Szepe',
+'kanoj:vger.kernel.org' =3D> 'Kanoj Sarcar', # sent by Arnaldo Carvalho =
de Melo
+'kanojsarcar:yahoo.com' =3D> 'Kanoj Sarcar',
+'kaos:ocs.com.au' =3D> 'Keith Owens',
+'kaos:sgi.com' =3D> 'Keith Owens', # sent by himself
+'kare.sars:lmf.ericsson.se' =3D> 'K=E5re S=E4rs',
+'kasperd:daimi.au.dk' =3D> 'Kasper Dupont',
+'keithu:parl.clemson.edu' =3D> 'Keith Underwood',
+'kenneth.w.chen:intel.com' =3D> 'Kenneth W. Chen',
+'kernel:jsl.com' =3D> 'Jeffrey S. Laing',
+'kernel:steeleye.com' =3D> 'Paul Clements',
+'key:austin.ibm.com' =3D> 'Kent Yoder',
+'khaho:koti.soon.fi' =3D> 'Ari Juhani H=E4meenaho',
+'khalid:fc.hp.com' =3D> 'Khalid Aziz',
+'khalid_aziz:hp.com' =3D> 'Khalid Aziz',
+'khc:pm.waw.pl' =3D> 'Krzysztof Halasa',
+'kiran:in.ibm.com' =3D> 'Ravikiran G. Thirumalai',
+'kisza:sch.bme.hu' =3D> 'Andras Kis-Szabo', # google (netfilter-ext HOWT=
O)
+'kkeil:suse.de' =3D> 'Karsten Keil',
+'kmsmith:umich.edu' =3D> 'Kendrick M. Smith',
+'knan:mo.himolde.no' =3D> 'Erik Inge Bols=F8',
+'kochi:hpc.bs1.fc.nec.co.jp' =3D> 'Kochi Takayoshi',
+'komujun:nifty.com' =3D> 'Jun Komuro', # google
+'kraxel:bytesex.org' =3D> 'Gerd Knorr',
+'kraxel:suse.de' =3D> 'Gerd Knorr',
+'krkumar:us.ibm.com' =3D> 'Krishna Kumar',
+'kronos:kronoz.cjb.net' =3D> 'Luca Tettamanti',
+'kuba:mareimbrium.org' =3D> 'Kuba Ober',
+'kuebelr:email.uc.edu' =3D> 'Robert Kuebel',
+'kunihiro:ipinfusion.com' =3D> 'Kunihiro Ishiguro',
+'kuznet:mops.inr.ac.ru' =3D> 'Alexey Kuznetsov',
+'kuznet:ms2.inr.ac.ru' =3D> 'Alexey Kuznetsov',
+'ladis:psi.cz' =3D> 'Ladislav Michl',
+'laforge:gnumonks.org' =3D> 'Harald Welte',
+'laforge:netfilter.org' =3D> 'Harald Welte',
+'latten:austin.ibm.com' =3D> 'Joy Latten',
+'laurent:latil.nom.fr' =3D> 'Laurent Latil',
+'lawrence:the-penguin.otak.com' =3D> 'Lawrence Walton',
+'ldb:ldb.ods.org' =3D> 'Luca Barbieri',
+'ldm:flatcap.org' =3D> 'Richard Russon',
+'lee:compucrew.com' =3D> 'Lee Nash', # lbdb
+'leigh:solinno.co.uk' =3D> 'Leigh Brown', # lbdb
+'levon:movementarian.org' =3D> 'John Levon',
+'lfo:polyad.org' =3D> 'Luis F. Ortiz',
+'linux:brodo.de' =3D> 'Dominik Brodowski',
+'linux:hazard.jcu.cz' =3D> 'Jan Marek',
+'lionel.bouton:inet6.fr' =3D> 'Lionel Bouton',
+'lists:mdiehl.de' =3D> 'Martin Diehl',
+'liyang:nerv.cx' =3D> 'Liyang Hu',
+'lm:bitmover.com' =3D> 'Larry McVoy',
+'lord:sgi.com' =3D> 'Stephen Lord',
+'louis.zhuang:linux.co.intel.com' =3D> 'Louis Zhuang',
+'louisk:cse.unsw.edu.au' =3D> 'Louis Yu-Kiu Kwan',
+'lowekamp:cs.wm.edu' =3D> 'Bruce B. Lowekamp', # lbdb
+'luben:splentec.com' =3D> 'Luben Tuikov',
+'luc.vanoostenryck:easynet.be' =3D> 'Luc Van Oostenryck', # lbdb
+'lucasvr:terra.com.br' =3D> 'Lucas Correia Villa Real', # google
+'lunz:falooley.org' =3D> 'Jason Lunz',
+'m.c.p:wolk-project.de' =3D> 'Marc-Christian Petersen',
+'maalanen:ra.abo.fi' =3D> 'Marcus Alanen',
+'mac:melware.de' =3D> 'Armin Schindler',
+'macro:ds2.pg.gda.pl' =3D> 'Maciej W. Rozycki',
+'manand:us.ibm.com' =3D> 'Mala Anand',
+'maneesh:in.ibm.com' =3D> 'Maneesh Soni',
+'manfred:colorfullife.com' =3D> 'Manfred Spraul',
+'manik:cisco.com' =3D> 'Manik Raina',
+'manish:zambeel.com' =3D> 'Manish Lachwani',
+'mannthey:us.ibm.com' =3D> 'Keith Mannthey',
+'marc:mbsi.ca' =3D> 'Marc Boucher',
+'marcel:holtmann.org' =3D> 'Marcel Holtmann', # sent by himself
+'marcelo:conectiva.com.br' =3D> 'Marcelo Tosatti',
+'marcelo:freak.distro.conectiva' =3D> 'Marcelo Tosatti', # guessed
+'marcelo:plucky.distro.conectiva' =3D> 'Marcelo Tosatti',
+'marcus:ingate.com' =3D> 'Marcus Sundberg',
+'marekm:amelek.gda.pl' =3D> 'Marek Michalkiewicz',
+'mark:alpha.dyndns.org' =3D> 'Mark W. McClelland',
+'mark:hal9000.dyndns.org' =3D> 'Mark W. McClelland',
+'markh:osdl.org' =3D> 'Mark Haverkamp',
+'martin.bligh:us.ibm.com' =3D> 'Martin J. Bligh',
+'martin:bruli.net' =3D> 'Martin Brulisauer',
+'martin:meltin.net' =3D> 'Martin Schwenke',
+'mason:suse.com' =3D> 'Chris Mason',
+'matt_domsch:dell.com' =3D> 'Matt Domsch', # sent by himself
+'matthew:wil.cx' =3D> 'Matthew Wilcox',
+'matthias.andree:gmx.de' =3D> 'Matthias Andree', # added by himself
+'mauelshagen:sistina.com' =3D> 'Heinz J. Mauelshagen',
+'maxk:qualcomm.com' =3D> 'Maksim Krasnyanskiy',
+'maxk:viper.(none)' =3D> 'Maksim Krasnyanskiy', # from shortlog
+'maxk:viper.qualcomm.com' =3D> 'Maksim Krasnyanskiy',
+'mb:ozaba.mine.nu' =3D> 'Magnus Boden',
+'mbligh:aracnet.com' =3D> 'Martin J. Bligh',
+'mcp:linux-systeme.de' =3D> 'Marc-Christian Petersen',
+'mdharm-scsi:one-eyed-alien.net' =3D> 'Matthew Dharm',
+'mdharm-usb:one-eyed-alien.net' =3D> 'Matthew Dharm',
+'mdharm:one-eyed-alien.net' =3D> 'Matthew Dharm',
+'mec:shout.net' =3D> 'Michael Elizabeth Chastain',
+'meissner:suse.de' =3D> 'Marcus Meissner',
+'mgreer:mvista.com' =3D> 'Mark A. Greer', # lbdb
+'michaelw:foldr.org' =3D> 'Michael Weber', # google
+'michal:harddata.com' =3D> 'Michal Jaegermann',
+'mikael.starvik:axis.com' =3D> 'Mikael Starvik',
+'mikal:stillhq.com' =3D> 'Michael Still',
+'mike:aiinc.ca' =3D> 'Michael Hayes',
+'mikep:linuxtr.net' =3D> 'Mike Phillips',
+'mikpe:csd.uu.se' =3D> 'Mikael Pettersson',
+'mikpe:user.it.uu.se' =3D> 'Mikael Pettersson',
+'mikulas:artax.karlin.mff.cuni.cz' =3D> 'Mikulas Patocka',
+'miles:lsi.nec.co.jp' =3D> 'Miles Bader',
+'miles:megapathdsl.net' =3D> 'Miles Lane',
+'milli:acmeps.com' =3D> 'Michael Milligan',
+'miltonm:bga.com' =3D> 'Milton Miller', # by Kristian Peters
+'mingo:elte.hu' =3D> 'Ingo Molnar',
+'mingo:redhat.com' =3D> 'Ingo Molnar',
+'miyazawa:linux-ipv6.org' =3D> 'Kazunori Miyazawa',
+'mj:ucw.cz' =3D> 'Martin Mares',
+'mk:linux-ipv6.org' =3D> 'Mitsuru Kanda',
+'mkp:mkp.net' =3D> 'Martin K. Petersen', # lbdb
+'mlang:delysid.org' =3D> 'Mario Lang', # google
+'mlindner:syskonnect.de' =3D> 'Mirko Lindner',
+'mlocke:mvista.com' =3D> 'Montavista Software, Inc.',
+'mmcclell:bigfoot.com' =3D> 'Mark McClelland',
+'mochel:geena.pdx.osdl.net' =3D> 'Patrick Mochel',
+'mochel:osdl.org' =3D> 'Patrick Mochel',
+'mochel:segfault.osdl.org' =3D> 'Patrick Mochel',
+'mostrows:speakeasy.net' =3D> 'Michal Ostrowski',
+'mporter:cox.net' =3D> 'Matt Porter',
+'msdemlei:cl.uni-heidelberg.de' =3D> 'Markus Demleitner',
+'msw:redhat.com' =3D> 'Matt Wilson',
+'mufasa:sis.com.tw' =3D> 'Mufasa Yang', # sent by himself
+'mulix:actcom.co.il' =3D> 'Muli Ben-Yehuda', # sent by himself
+'mulix:mulix.org' =3D> 'Muli Ben-Yehuda',
+'mw:microdata-pos.de' =3D> 'Michael Westermann',
+'mzyngier:freesurf.fr' =3D> 'Marc Zyngier',
+'n0ano:n0ano.com' =3D> 'Don Dugger',
+'nahshon:actcom.co.il' =3D> 'Itai Nahshon',
+'nathans:sgi.com' =3D> 'Nathan Scott',
+'neilb:cse.unsw.edu.au' =3D> 'Neil Brown',
+'neilt:slimy.greenend.org.uk' =3D> 'Neil Turton',
+'nemosoft:smcc.demon.nl' =3D> 'Nemosoft Unv.',
+'netfilter:interlinx.bc.ca' =3D> 'Brian J. Murrell',
+'nick.holloway:pyrites.org.uk' =3D> 'Nick Holloway',
+'nico:cam.org' =3D> 'Nicolas Pitre',
+'nicolas.aspert:epfl.ch' =3D> 'Nicolas Aspert',
+'nicolas.mailhot:laposte.net' =3D> 'Nicolas Mailhot',
+'nkbj:image.dk' =3D> 'Niels Kristian Bech Jensen',
+'nlaredo:transmeta.com' =3D> 'Nathan Laredo',
+'nmiell:attbi.com' =3D> 'Nicholas Miell',
+'nobita:t-online.de' =3D> 'Andreas Busch',
+'okir:suse.de' =3D> 'Olaf Kirch', # lbdb
+'okurth:gmx.net' =3D> 'Oliver Kurth',
+'olaf.dietsche#list.linux-kernel:t-online.de' =3D> 'Olaf Dietsche',
 'olaf.dietsche' =3D> 'Olaf Dietsche',
-'oleg@tv-sign.ru' =3D> 'Oleg Nesterov',
-'olh@suse.de' =3D> 'Olaf Hering',
-'oliendm@us.ibm.com' =3D> 'Dave Olien',
-'oliver.neukum@lrz.uni-muenchen.de' =3D> 'Oliver Neukum',
-'oliver@neukum.name' =3D> 'Oliver Neukum',
-'oliver@neukum.org' =3D> 'Oliver Neukum',
-'oliver@oenone.homelinux.org' =3D> 'Oliver Neukum',
-'orjan.friberg@axis.com' =3D> 'Orjan Friberg',
-'os@emlix.com' =3D> 'Oskar Schirmer', # sent by himself
-'osst@riede.org' =3D> 'Willem Riede',
-'otaylor@redhat.com' =3D> 'Owen Taylor',
-'overby@sgi.com' =3D> 'Glen Overby',
-'p.guehring@futureware.at' =3D> 'Philipp G=FChring',
-'p2@ace.ulyssis.sutdent.kuleuven.ac.be' =3D> 'Peter De Shrijver',
-'p_gortmaker@yahoo.com' =3D> 'Paul Gortmaker',
-'pam.delaney@lsil.com' =3D> 'Pamela Delaney',
-'pasky@ucw.cz' =3D> 'Petr Baudis',
-'patmans@us.ibm.com' =3D> 'Patrick Mansfield',
-'paubert@iram.es' =3D> 'Gabriel Paubert',
-'paul.mundt@timesys.com' =3D> 'Paul Mundt', # google
-'paulkf@microgate.com' =3D> 'Paul Fulghum',
-'paulus@au1.ibm.com' =3D> 'Paul Mackerras',
-'paulus@nanango.paulus.ozlabs.org' =3D> 'Paul Mackerras',
-'paulus@quango.ozlabs.ibm.com' =3D> 'Paul Mackerras',
-'paulus@samba.org' =3D> 'Paul Mackerras',
-'pavel@janik.cz' =3D> 'Pavel Jan=EDk',
-'pavel@suse.cz' =3D> 'Pavel Machek',
-'pavel@ucw.cz' =3D> 'Pavel Machek',
-'pazke@orbita1.ru' =3D> 'Andrey Panin',
-'pbadari@us.ibm.com' =3D> 'Badari Pulavarty',
-'pdelaney@lsil.com' =3D> 'Pam Delaney',
-'pe1rxq@amsat.org' =3D> 'Jeroen Vreeken',
-'pekon@informatics.muni.cz' =3D> 'Petr Konecny',
-'perex@perex.cz' =3D> 'Jaroslav Kysela',
-'perex@pnote.perex-int.cz' =3D> 'Jaroslav Kysela',
-'perex@suse.cz' =3D> 'Jaroslav Kysela',
-'peter@bergner.org' =3D> 'Peter Bergner',
-'peter@cadcamlab.org' =3D> 'Peter Samuelson',
-'peter@chubb.wattle.id.au' =3D> 'Peter Chubb',
-'peterc@gelato.unsw.edu.au' =3D> 'Peter Chubb',
-'petero2@telia.com' =3D> 'Peter Osterlund',
-'petkan@mastika.dce.bg' =3D> 'Petko Manolov',
-'petkan@rakia.dce.bg' =3D> 'Petko Manolov',
-'petkan@rakia.hell.org' =3D> 'Petko Manolov',
-'petkan@tequila.dce.bg' =3D> 'Petko Manolov',
-'petkan@users.sourceforge.net' =3D> 'Petko Manolov',
-'petr@vandrovec.name' =3D> 'Petr Vandrovec',
-'petri.koistinen@iki.fi' =3D> 'Petri Koistinen',
-'phillim2@comcast.net' =3D> 'Mike Phillips',
-'pkot@linuxnews.pl' =3D> 'Pawel Kot',
-'plars@austin.ibm.com' =3D> 'Paul Larson',
-'plcl@telefonica.net' =3D> 'Pedro Lopez-Cabanillas',
-'pmenage@ensim.com' =3D> 'Paul Menage',
-'porter@cox.net' =3D> 'Matt Porter',
-'prom@berlin.ccc.de' =3D> 'Ingo Albrecht',
-'proski@gnu.org' =3D> 'Pavel Roskin',
-'pwaechtler@mac.com' =3D> 'Peter W=E4chtler',
-'quinlan@transmeta.com' =3D> 'Daniel Quinlan',
-'quintela@mandrakesoft.com' =3D> 'Juan Quintela',
-'r.e.wolff@bitwizard.nl' =3D> 'Rogier Wolff', # lbdbq
-'ralf@dea.linux-mips.net' =3D> 'Ralf B=E4chle',
-'ralf@linux-mips.org' =3D> 'Ralf B=E4chle',
-'ramune@net-ronin.org' =3D> 'Daniel A. Nobuto',
-'randy.dunlap@verizon.net' =3D> 'Randy Dunlap',
-'raul@pleyades.net' =3D> 'Raul Nunez de Arenas Coronado',
-'ray-lk@madrabbit.org' =3D> 'Ray Lee',
-'rbh00@utsglobal.com' =3D> 'Richard Hitt', # asked him, he prefers Richa=
rd
-'rbt@mtlb.co.uk' =3D> 'Robert Cardell',
-'rct@gherkin.frus.com' =3D> 'Bob Tracy',
-'rddunlap@osdl.org' =3D> 'Randy Dunlap',
-'reality@delusion.de' =3D> 'Udo A. Steinberg',
-'reiser@namesys.com' =3D> 'Hans Reiser',
-'rem@osdl.org' =3D> 'Bob Miller',
-'rgooch@atnf.csiro.au' =3D> 'Richard Gooch',
-'rgooch@ras.ucalgary.ca' =3D> 'Richard Gooch',
-'rgs@linalco.com' =3D> 'Roberto Gordo Saez',
-'rhirst@linuxcare.com' =3D> 'Richard Hirst',
-'rhw@infradead.org' =3D> 'Riley Williams',
-'richard.brunner@amd.com' =3D> 'Richard Brunner',
-'riel@conectiva.com.br' =3D> 'Rik van Riel',
-'rjweryk@uwo.ca' =3D> 'Rob Weryk',
-'rl@hellgate.ch' =3D> 'Roger Luethi',
-'rlievin@free.fr' =3D> 'Romain Lievin',
-'rmk@arm.linux.org.uk' =3D> 'Russell King',
-'rmk@flint.arm.linux.org.uk' =3D> 'Russell King',
-'rml@tech9.net' =3D> 'Robert Love',
-'rob@osinvestor.com' =3D> 'Rob Radez',
-'robert.olsson@data.slu.se' =3D> 'Robert Olsson',
-'roehrich@sgi.com' =3D> 'Dean Roehrich',
-'rohit.seth@intel.com' =3D> 'Rohit Seth',
-'rol@as2917.net' =3D> 'Paul Rolland',
-'roland@frob.com' =3D> 'Roland McGrath',
-'roland@redhat.com' =3D> 'Roland McGrath',
-'roland@topspin.com' =3D> 'Roland Dreier',
-'romieu@cogenit.fr' =3D> 'Fran=E7ois Romieu',
-'romieu@fr.zoreil.com' =3D> 'Fran=E7ois Romieu',
-'root@viper.(none)' =3D> 'Maxim Krasnyansky',
-'rread@clusterfs.com' =3D> 'Robert Read',
-'rscott@attbi.com' =3D> 'Rob Scott',
-'rth@are.twiddle.net' =3D> 'Richard Henderson',
-'rth@dorothy.sfbay.redhat.com' =3D> 'Richard Henderson',
-'rth@dot.sfbay.redhat.com' =3D> 'Richard Henderson',
-'rth@kanga.twiddle.net' =3D> 'Richard Henderson',
-'rth@splat.sfbay.redhat.com' =3D> 'Richard Henderson',
-'rth@twiddle.net' =3D> 'Richard Henderson',
-'rth@vsop.sfbay.redhat.com' =3D> 'Richard Henderson',
-'rui.sousa@laposte.net' =3D> 'Rui Sousa',
-'rusty@rustcorp.com.au' =3D> 'Rusty Russell',
-'rvinson@mvista.com' =3D> 'Randy Vinson',
-'rwhron@earthlink.net' =3D> 'Randy Hron',
-'rz@linux-m68k.org' =3D> 'Richard Zidlicky',
-'sabala@students.uiuc.edu' =3D> 'Michal Sabala', # google
-'sailer@scs.ch' =3D> 'Thomas Sailer',
-'sam@mars.ravnborg.org' =3D> 'Sam Ravnborg',
-'sam@ravnborg.org' =3D> 'Sam Ravnborg',
-'samel@mail.cz' =3D> 'Vitezslav Samel',
-'samuel.thibault@ens-lyon.fr' =3D> 'Samuel Thibault',
-'sandeen@sgi.com' =3D> 'Eric Sandeen',
-'santiago@newphoenix.net' =3D> 'Santiago A. Nullo', # sent by self
-'sarolaht@cs.helsinki.fi' =3D> 'Pasi Sarolahti',
-'sawa@yamamoto.gr.jp' =3D> 'sawa',
-'schoenfr@gaaertner.de' =3D> 'Erik Schoenfelder',
-'schwab@suse.de' =3D> 'Andreas Schwab',
-'schwidefsky@de.ibm.com' =3D> 'Martin Schwidefsky',
-'scott.feldman@intel.com' =3D> 'Scott Feldman',
-'scott_anderson@mvista.com' =3D> 'Scott Anderson',
-'scottm@somanetworks.com' =3D> 'Scott Murray',
-'sct@redhat.com' =3D> 'Stephen C. Tweedie',
-'sds@epoch.ncsc.mil' =3D> 'Stephen D. Smalley',
-'sds@tislabs.com' =3D> 'Stephen D. Smalley',
-'sebastian.droege@gmx.de' =3D> 'Sebastian Dr=F6ge',
-'sfbest@us.ibm.com' =3D> 'Steve Best',
-'sfr@canb.auug.org.au' =3D> 'Stephen Rothwell',
-'shaggy@austin.ibm.com' =3D> 'Dave Kleikamp',
-'shaggy@kleikamp.austin.ibm.com' =3D> 'Dave Kleikamp',
-'shaggy@shaggy.austin.ibm.com' =3D> 'Dave Kleikamp', # lbdb
-'shemminger@osdl.org' =3D> 'Stephen Hemminger',
-'shields@msrl.com' =3D> 'Michael Shields',
-'shingchuang@via.com.tw' =3D> 'Shing Chuang',
-'silicon@falcon.sch.bme.hu' =3D> 'Szil=E1rd P=E1sztor', # google
-'simonb@lipsyncpost.co.uk' =3D> 'Simon Burley',
-'skip.ford@verizon.net' =3D> 'Skip Ford',
-'sl@lineo.com' =3D> 'Stuart Lynne',
-'smurf@osdl.org' =3D> 'Nathan Dabney',
-'snailtalk@linux-mandrake.com' =3D> 'Geoffrey Lee', # by himself
-'solar@openwall.com' =3D> 'Solar Designer',
-'sparker@sun.com' =3D> 'Steven Parker', # by Duncan Laurie
-'sprite@sprite.fr.eu.org' =3D> 'Jeremie Koenig',
-'spse@secret.org.uk' =3D> 'Simon Evans', # by Kristian Peters
-'sri@us.ibm.com' =3D> 'Sridhar Samudrala',
-'sridhar@dyn9-47-18-140.beaverton.ibm.com' =3D> 'Sridhar Samudrala',
-'sridhar@dyn9-47-18-86.beaverton.ibm.com' =3D> 'Sridhar Samudrala',
-'sridhar@x1-6-00-10-a4-8b-06-f6.attbi.com' =3D> 'Sridhar Samudrala',
-'srompf@isg.de' =3D> 'Stefan Rompf',
-'stanley.wang@linux.co.intel.com' =3D> 'Stanley Wang',
-'steiner@sgi.com' =3D> 'Jack Steiner',
-'stekloff@w-stekloff.beaverton.ibm.com' =3D> 'Daniel Stekloff',
-'stelian.pop@fr.alcove.com' =3D> 'Stelian Pop',
-'stelian@popies.net' =3D> 'Stelian Pop',
-'stern@rowland.harvard.edu' =3D> 'Alan Stern',
-'stern@rowland.org' =3D> 'Alan Stern', # lbdb
-'steve.cameron@hp.com' =3D> 'Stephen Cameron',
-'steve@chygwyn.com' =3D> 'Steven Whitehouse',
-'steve@gw.chygwyn.com' =3D> 'Steven Whitehouse',
-'steve@kbuxd.necst.nec.co.jp' =3D> 'SL Baur',
-'stevef@smfhome1.austin.rr.com' =3D> 'Steve French',
-'stevef@steveft21.austin.ibm.com' =3D> 'Steve French',
-'stevef@steveft21.ltcsamba' =3D> 'Steve French',
-'stuartm@connecttech.com' =3D> 'Stuart MacDonald',
-'sullivan@austin.ibm.com' =3D> 'Mike Sullivan',
-'suncobalt.adm@hostme.bitkeeper.com' =3D> 'Tim Hockin', # by Duncan Laur=
ie
-'sunil.saxena@intel.com' =3D> 'Sunil Saxena',
-'suresh.b.siddha@intel.com' =3D> 'Suresh B. Siddha',
-'swanson@uklinux.net' =3D> 'Alan Swanson',
-'szepe@pinerecords.com' =3D> 'Tomas Szepe',
-'t-kouchi@mvf.biglobe.ne.jp' =3D> 'Takayoshi Kouchi',
-'tai@imasy.or.jp' =3D> 'Taisuke Yamada',
-'taka@valinux.co.jp' =3D> 'Hirokazu Takahashi',
-'tinglett@vnet.ibm.com' =3D> 'Todd Inglett',
-'tao@acc.umu.se' =3D> 'David Weinehall', # by himself
-'tao@kernel.org' =3D> 'David Weinehall', # by himself
-'tcallawa@redhat.com' =3D> 'Tom Callaway',
-'tetapi@utu.fi' =3D> 'Tero Pirkkanen', # by Kristian Peters
-'th122948@scl1.sfbay.sun.com' =3D> 'Tim Hockin', # by Duncan Laurie
-'th122948@scl3.sfbay.sun.com' =3D> 'Tim Hockin', # by Duncan Laurie
-'thiel@ksan.de' =3D> 'Florian Thiel', # lbdb
-'thockin@freakshow.cobalt.com' =3D> 'Tim Hockin',
-'thockin@sun.com' =3D> 'Tim Hockin',
-'thomas@bender.thinknerd.de' =3D> 'Thomas Walpuski',
-'tigran@aivazian.name' =3D> 'Tigran Aivazian',
-'tim@physik3.uni-rostock.de' =3D> 'Tim Schmielau',
-'tmcreynolds@nvidia.com' =3D> 'Tom McReynolds',
-'tmolina@cox.net' =3D> 'Thomas Molina',
-'toml@us.ibm.com' =3D> 'Tom Lendacky',
-'tomita@cinet.co.jp' =3D> 'Osamu Tomita',
-'tomlins@cam.org' =3D> 'Ed Tomlinson',
-'tony.luck@intel.com' =3D> 'Tony Luck',
-'tony@cantech.net.au' =3D> 'Anthony J. Breeds-Taurima',
-'torvalds@athlon.transmeta.com' =3D> 'Linus Torvalds',
-'torvalds@home.transmeta.com' =3D> 'Linus Torvalds',
-'torvalds@kiwi.transmeta.com' =3D> 'Linus Torvalds',
-'torvalds@penguin.transmeta.com' =3D> 'Linus Torvalds',
-'torvalds@tove.transmeta.com' =3D> 'Linus Torvalds',
-'torvalds@transmeta.com' =3D> 'Linus Torvalds',
-'trini@bill-the-cat.bloom.county' =3D> 'Tom Rini',
-'trini@kernel.crashing.org' =3D> 'Tom Rini',
-'trond.myklebust@fys.uio.no' =3D> 'Trond Myklebust',
-'tvignaud@mandrakesoft.com' =3D> 'Thierry Vignaud',
-'tvrtko@net4u.hr' =3D> 'Tvrtko A. Ursulin',
-'twaugh@redhat.com' =3D> 'Tim Waugh',
-'tytso@mit.edu' =3D> "Theodore Ts'o", # web.mit.edu/tytso/www/home.html
-'tytso@snap.thunk.org' =3D> "Theodore Ts'o",
-'tytso@think.thunk.org' =3D> "Theodore Ts'o", # guessed
-'urban@teststation.com' =3D> 'Urban Widmark',
-'uzi@uzix.org' =3D> 'Joshua Uziel',
-'valko@linux.karinthy.hu' =3D> 'Laszlo Valko',
-'vandrove@vc.cvut.cz' =3D> 'Petr Vandrovec',
-'vanl@megsinet.net' =3D> 'Martin H. VanLeeuwen',
-'varenet@parisc-linux.org' =3D> 'Thibaut Varene',
-'vberon@mecano.gme.usherb.ca' =3D> 'Vincent B=E9ron',
-'venkatesh.pallipadi@intel.com' =3D> 'Venkatesh Pallipadi',
-'viro@math.psu.edu' =3D> 'Alexander Viro',
-'vojta@math.berkeley.edu' =3D> 'Paul Vojta',
-'vojtech@suse.cz' =3D> 'Vojtech Pavlik',
-'vojtech@twilight.ucw.cz' =3D> 'Vojtech Pavlik',
-'vojtech@ucw.cz' =3D> 'Vojtech Pavlik', # added by himself
-'wa@almesberger.net' =3D> 'Werner Almesberger',
-'wahrenbruch@kobil.de' =3D> 'Thomas Wahrenbruch',
-'warlord@mit.edu' =3D> 'Derek Atkins',
-'wd@denx.de' =3D> 'Wolfgang Denk',
-'weigand@immd1.informatik.uni-erlangen.de' =3D> 'Ulrich Weigand',
-'wes@infosink.com' =3D> 'Wes Schreiner',
-'wg@malloc.de' =3D> 'Wolfram Gloger', # lbdb
-'whitney@math.berkeley.edu' =3D> 'Wayne Whitney',
-'will@sowerbutts.com' =3D> 'William R. Sowerbutts',
-'willy@debian.org' =3D> 'Matthew Wilcox',
-'willy@fc.hp.com' =3D> 'Matthew Wilcox',
-'willy@w.ods.org' =3D> 'Willy Tarreau',
-'wilsonc@abocom.com.tw' =3D> 'Wilson Chen', # google
-'wim@iguana.be' =3D> 'Wim Van Sebroeck',
-'wli@holomorphy.com' =3D> 'William Lee Irwin III',
-'wolfgang.fritz@gmx.net' =3D> 'Wolfgang Fritz', # by Kristian Peters
-'wolfgang@iksw-muees.de' =3D> 'Wolfgang Muees',
-'wriede@riede.org' =3D> 'Willem Riede',
-'wrlk@riede.org' =3D> 'Willem Riede',
-'wstinson@infonie.fr' =3D> 'William Stinson',
-'wstinson@wanadoo.fr' =3D> 'William Stinson',
-'xkaspa06@stud.fee.vutbr.cz' =3D> 'Tomas Kasparek',
-'ya@slamail.org' =3D> 'Yaacov Akiba Slama',
-'yokota@netlab.is.tsukuba.ac.jp' =3D> 'Yokota Hiroshi',
-'yoshfuji@linux-ipv6.org' =3D> 'Hideaki Yoshifuji', # lbdb
-'yoshfuji@nuts.ninka.net' =3D> 'Hideaki Yoshifuji',
-'yuri@acronis.com' =3D> 'Yuri Per', # lbdb
-'zaitcev@redhat.com' =3D> 'Pete Zaitcev',
-'zinx@epicsol.org' =3D> 'Zinx Verituse',
-'zippel@linux-m68k.org' =3D> 'Roman Zippel',
-'zubarev@us.ibm.com' =3D> 'Irene Zubarev', # google
-'zwane@commfireservices.com' =3D> 'Zwane Mwaikambo',
-'zwane@holomorphy.com' =3D> 'Zwane Mwaikambo',
-'zwane@linuxpower.ca' =3D> 'Zwane Mwaikambo',
-'zwane@mwaikambo.name' =3D> 'Zwane Mwaikambo',
+'oleg:tv-sign.ru' =3D> 'Oleg Nesterov',
+'olh:suse.de' =3D> 'Olaf Hering',
+'oliendm:us.ibm.com' =3D> 'Dave Olien',
+'oliver.neukum:lrz.uni-muenchen.de' =3D> 'Oliver Neukum',
+'oliver.spang:siemens.com' =3D> 'Oliver Spang',
+'oliver:neukum.name' =3D> 'Oliver Neukum',
+'oliver:neukum.org' =3D> 'Oliver Neukum',
+'oliver:oenone.homelinux.org' =3D> 'Oliver Neukum',
+'orjan.friberg:axis.com' =3D> 'Orjan Friberg',
+'os:emlix.com' =3D> 'Oskar Schirmer', # sent by himself
+'osst:riede.org' =3D> 'Willem Riede',
+'otaylor:redhat.com' =3D> 'Owen Taylor',
+'overby:sgi.com' =3D> 'Glen Overby',
+'p.guehring:futureware.at' =3D> 'Philipp G=FChring',
+'p2:ace.ulyssis.sutdent.kuleuven.ac.be' =3D> 'Peter De Shrijver',
+'p_gortmaker:yahoo.com' =3D> 'Paul Gortmaker',
+'pam.delaney:lsil.com' =3D> 'Pamela Delaney',
+'pasky:ucw.cz' =3D> 'Petr Baudis',
+'patmans:us.ibm.com' =3D> 'Patrick Mansfield',
+'paubert:iram.es' =3D> 'Gabriel Paubert',
+'paul.mundt:timesys.com' =3D> 'Paul Mundt', # google
+'paulkf:microgate.com' =3D> 'Paul Fulghum',
+'paulm:routefree.com' =3D> 'Paul Mielke',
+'paulus:au1.ibm.com' =3D> 'Paul Mackerras',
+'paulus:nanango.paulus.ozlabs.org' =3D> 'Paul Mackerras',
+'paulus:quango.ozlabs.ibm.com' =3D> 'Paul Mackerras',
+'paulus:samba.org' =3D> 'Paul Mackerras',
+'pavel:janik.cz' =3D> 'Pavel Jan=EDk',
+'pavel:suse.cz' =3D> 'Pavel Machek',
+'pavel:ucw.cz' =3D> 'Pavel Machek',
+'pazke:orbita1.ru' =3D> 'Andrey Panin',
+'pbadari:us.ibm.com' =3D> 'Badari Pulavarty',
+'pdelaney:lsil.com' =3D> 'Pam Delaney',
+'pe1rxq:amsat.org' =3D> 'Jeroen Vreeken',
+'pekon:informatics.muni.cz' =3D> 'Petr Konecny',
+'perex:perex.cz' =3D> 'Jaroslav Kysela',
+'perex:pnote.perex-int.cz' =3D> 'Jaroslav Kysela',
+'perex:suse.cz' =3D> 'Jaroslav Kysela',
+'peter:bergner.org' =3D> 'Peter Bergner',
+'peter:cadcamlab.org' =3D> 'Peter Samuelson',
+'peter:chubb.wattle.id.au' =3D> 'Peter Chubb',
+'peterc:gelato.unsw.edu.au' =3D> 'Peter Chubb',
+'petero2:telia.com' =3D> 'Peter Osterlund',
+'petkan:mastika.dce.bg' =3D> 'Petko Manolov',
+'petkan:rakia.dce.bg' =3D> 'Petko Manolov',
+'petkan:rakia.hell.org' =3D> 'Petko Manolov',
+'petkan:tequila.dce.bg' =3D> 'Petko Manolov',
+'petkan:users.sourceforge.net' =3D> 'Petko Manolov',
+'petr:vandrovec.name' =3D> 'Petr Vandrovec',
+'petri.koistinen:iki.fi' =3D> 'Petri Koistinen',
+'phillim2:comcast.net' =3D> 'Mike Phillips',
+'pkot:linuxnews.pl' =3D> 'Pawel Kot',
+'plars:austin.ibm.com' =3D> 'Paul Larson',
+'plcl:telefonica.net' =3D> 'Pedro Lopez-Cabanillas',
+'pmenage:ensim.com' =3D> 'Paul Menage',
+'porter:cox.net' =3D> 'Matt Porter',
+'prom:berlin.ccc.de' =3D> 'Ingo Albrecht',
+'proski:gnu.org' =3D> 'Pavel Roskin',
+'pwaechtler:mac.com' =3D> 'Peter W=E4chtler',
+'quinlan:transmeta.com' =3D> 'Daniel Quinlan',
+'quintela:mandrakesoft.com' =3D> 'Juan Quintela',
+'r.e.wolff:bitwizard.nl' =3D> 'Rogier Wolff', # lbdbq
+'ralf:dea.linux-mips.net' =3D> 'Ralf B=E4chle',
+'ralf:linux-mips.org' =3D> 'Ralf B=E4chle',
+'ramune:net-ronin.org' =3D> 'Daniel A. Nobuto',
+'randolph:tausq.org' =3D> 'Randolph Chung',
+'randy.dunlap:verizon.net' =3D> 'Randy Dunlap',
+'raul:pleyades.net' =3D> 'Raul Nunez de Arenas Coronado',
+'ray-lk:madrabbit.org' =3D> 'Ray Lee',
+'rbh00:utsglobal.com' =3D> 'Richard Hitt', # asked him, he prefers Richa=
rd
+'rbt:mtlb.co.uk' =3D> 'Robert Cardell',
+'rct:gherkin.frus.com' =3D> 'Bob Tracy',
+'rddunlap:osdl.org' =3D> 'Randy Dunlap',
+'reality:delusion.de' =3D> 'Udo A. Steinberg',
+'reiser:namesys.com' =3D> 'Hans Reiser',
+'rem:osdl.org' =3D> 'Bob Miller',
+'rgooch:atnf.csiro.au' =3D> 'Richard Gooch',
+'rgooch:ras.ucalgary.ca' =3D> 'Richard Gooch',
+'rgs:linalco.com' =3D> 'Roberto Gordo Saez',
+'rhirst:linuxcare.com' =3D> 'Richard Hirst',
+'rhw:infradead.org' =3D> 'Riley Williams',
+'richard.brunner:amd.com' =3D> 'Richard Brunner',
+'riel:conectiva.com.br' =3D> 'Rik van Riel',
+'rjweryk:uwo.ca' =3D> 'Rob Weryk',
+'rl:hellgate.ch' =3D> 'Roger Luethi',
+'rlievin:free.fr' =3D> 'Romain Lievin',
+'rmk:arm.linux.org.uk' =3D> 'Russell King',
+'rmk:flint.arm.linux.org.uk' =3D> 'Russell King',
+'rml:tech9.net' =3D> 'Robert Love',
+'rob:osinvestor.com' =3D> 'Rob Radez',
+'robert.olsson:data.slu.se' =3D> 'Robert Olsson',
+'roehrich:sgi.com' =3D> 'Dean Roehrich',
+'rohit.seth:intel.com' =3D> 'Rohit Seth',
+'rol:as2917.net' =3D> 'Paul Rolland',
+'roland:frob.com' =3D> 'Roland McGrath',
+'roland:redhat.com' =3D> 'Roland McGrath',
+'roland:topspin.com' =3D> 'Roland Dreier',
+'romieu:cogenit.fr' =3D> 'Fran=E7ois Romieu',
+'romieu:fr.zoreil.com' =3D> 'Fran=E7ois Romieu',
+'root:viper.(none)' =3D> 'Maxim Krasnyansky',
+'rread:clusterfs.com' =3D> 'Robert Read',
+'rscott:attbi.com' =3D> 'Rob Scott',
+'rth:are.twiddle.net' =3D> 'Richard Henderson',
+'rth:dorothy.sfbay.redhat.com' =3D> 'Richard Henderson',
+'rth:dot.sfbay.redhat.com' =3D> 'Richard Henderson',
+'rth:kanga.twiddle.net' =3D> 'Richard Henderson',
+'rth:splat.sfbay.redhat.com' =3D> 'Richard Henderson',
+'rth:twiddle.net' =3D> 'Richard Henderson',
+'rth:vsop.sfbay.redhat.com' =3D> 'Richard Henderson',
+'rui.sousa:laposte.net' =3D> 'Rui Sousa',
+'rusty:rustcorp.com.au' =3D> 'Rusty Russell',
+'rvinson:mvista.com' =3D> 'Randy Vinson',
+'rwhron:earthlink.net' =3D> 'Randy Hron',
+'rz:linux-m68k.org' =3D> 'Richard Zidlicky',
+'sabala:students.uiuc.edu' =3D> 'Michal Sabala', # google
+'sailer:scs.ch' =3D> 'Thomas Sailer',
+'sam:mars.ravnborg.org' =3D> 'Sam Ravnborg',
+'sam:ravnborg.org' =3D> 'Sam Ravnborg',
+'samel:mail.cz' =3D> 'Vitezslav Samel',
+'samuel.thibault:ens-lyon.fr' =3D> 'Samuel Thibault',
+'sandeen:sgi.com' =3D> 'Eric Sandeen',
+'santiago:newphoenix.net' =3D> 'Santiago A. Nullo', # sent by self
+'sarolaht:cs.helsinki.fi' =3D> 'Pasi Sarolahti',
+'sawa:yamamoto.gr.jp' =3D> 'sawa',
+'schoenfr:gaaertner.de' =3D> 'Erik Schoenfelder',
+'schwab:suse.de' =3D> 'Andreas Schwab',
+'schwidefsky:de.ibm.com' =3D> 'Martin Schwidefsky',
+'scott.feldman:intel.com' =3D> 'Scott Feldman',
+'scott_anderson:mvista.com' =3D> 'Scott Anderson',
+'scottm:somanetworks.com' =3D> 'Scott Murray',
+'sct:redhat.com' =3D> 'Stephen C. Tweedie',
+'sds:epoch.ncsc.mil' =3D> 'Stephen D. Smalley',
+'sds:tislabs.com' =3D> 'Stephen D. Smalley',
+'sebastian.droege:gmx.de' =3D> 'Sebastian Dr=F6ge',
+'sfbest:us.ibm.com' =3D> 'Steve Best',
+'sfr:canb.auug.org.au' =3D> 'Stephen Rothwell',
+'shaggy:austin.ibm.com' =3D> 'Dave Kleikamp',
+'shaggy:kleikamp.austin.ibm.com' =3D> 'Dave Kleikamp',
+'shaggy:shaggy.austin.ibm.com' =3D> 'Dave Kleikamp', # lbdb
+'shemminger:osdl.org' =3D> 'Stephen Hemminger',
+'shields:msrl.com' =3D> 'Michael Shields',
+'shingchuang:via.com.tw' =3D> 'Shing Chuang',
+'silicon:falcon.sch.bme.hu' =3D> 'Szil=E1rd P=E1sztor', # google
+'simonb:lipsyncpost.co.uk' =3D> 'Simon Burley',
+'skip.ford:verizon.net' =3D> 'Skip Ford',
+'sl:lineo.com' =3D> 'Stuart Lynne',
+'smurf:osdl.org' =3D> 'Nathan Dabney',
+'snailtalk:linux-mandrake.com' =3D> 'Geoffrey Lee', # by himself
+'solar:openwall.com' =3D> 'Solar Designer',
+'sparker:sun.com' =3D> 'Steven Parker', # by Duncan Laurie
+'sprite:sprite.fr.eu.org' =3D> 'Jeremie Koenig',
+'spse:secret.org.uk' =3D> 'Simon Evans', # by Kristian Peters
+'sri:us.ibm.com' =3D> 'Sridhar Samudrala',
+'sridhar:dyn9-47-18-140.beaverton.ibm.com' =3D> 'Sridhar Samudrala',
+'sridhar:dyn9-47-18-86.beaverton.ibm.com' =3D> 'Sridhar Samudrala',
+'sridhar:x1-6-00-10-a4-8b-06-f6.attbi.com' =3D> 'Sridhar Samudrala',
+'srompf:isg.de' =3D> 'Stefan Rompf',
+'stanley.wang:linux.co.intel.com' =3D> 'Stanley Wang',
+'steiner:sgi.com' =3D> 'Jack Steiner',
+'stekloff:w-stekloff.beaverton.ibm.com' =3D> 'Daniel Stekloff',
+'stelian.pop:fr.alcove.com' =3D> 'Stelian Pop',
+'stelian:popies.net' =3D> 'Stelian Pop',
+'stern:rowland.harvard.edu' =3D> 'Alan Stern',
+'stern:rowland.org' =3D> 'Alan Stern', # lbdb
+'steve.cameron:hp.com' =3D> 'Stephen Cameron',
+'steve:chygwyn.com' =3D> 'Steven Whitehouse',
+'steve:gw.chygwyn.com' =3D> 'Steven Whitehouse',
+'steve:kbuxd.necst.nec.co.jp' =3D> 'SL Baur',
+'stevef:smfhome1.austin.rr.com' =3D> 'Steve French',
+'stevef:steveft21.austin.ibm.com' =3D> 'Steve French',
+'stevef:steveft21.ltcsamba' =3D> 'Steve French',
+'stuartm:connecttech.com' =3D> 'Stuart MacDonald',
+'sullivan:austin.ibm.com' =3D> 'Mike Sullivan',
+'suncobalt.adm:hostme.bitkeeper.com' =3D> 'Tim Hockin', # by Duncan Laur=
ie
+'sunil.saxena:intel.com' =3D> 'Sunil Saxena',
+'suresh.b.siddha:intel.com' =3D> 'Suresh B. Siddha',
+'swanson:uklinux.net' =3D> 'Alan Swanson',
+'szepe:pinerecords.com' =3D> 'Tomas Szepe',
+'t-kouchi:mvf.biglobe.ne.jp' =3D> 'Takayoshi Kouchi',
+'tai:imasy.or.jp' =3D> 'Taisuke Yamada',
+'taka:valinux.co.jp' =3D> 'Hirokazu Takahashi',
+'tinglett:vnet.ibm.com' =3D> 'Todd Inglett',
+'tao:acc.umu.se' =3D> 'David Weinehall', # by himself
+'tao:kernel.org' =3D> 'David Weinehall', # by himself
+'tcallawa:redhat.com' =3D> 'Tom Callaway',
+'tetapi:utu.fi' =3D> 'Tero Pirkkanen', # by Kristian Peters
+'th122948:scl1.sfbay.sun.com' =3D> 'Tim Hockin', # by Duncan Laurie
+'th122948:scl3.sfbay.sun.com' =3D> 'Tim Hockin', # by Duncan Laurie
+'thiel:ksan.de' =3D> 'Florian Thiel', # lbdb
+'thockin:freakshow.cobalt.com' =3D> 'Tim Hockin',
+'thockin:sun.com' =3D> 'Tim Hockin',
+'thomas:bender.thinknerd.de' =3D> 'Thomas Walpuski',
+'tigran:aivazian.name' =3D> 'Tigran Aivazian',
+'tim:physik3.uni-rostock.de' =3D> 'Tim Schmielau',
+'tmcreynolds:nvidia.com' =3D> 'Tom McReynolds',
+'tmolina:cox.net' =3D> 'Thomas Molina',
+'toml:us.ibm.com' =3D> 'Tom Lendacky',
+'tomita:cinet.co.jp' =3D> 'Osamu Tomita',
+'tomlins:cam.org' =3D> 'Ed Tomlinson',
+'tony.luck:intel.com' =3D> 'Tony Luck',
+'tony:cantech.net.au' =3D> 'Anthony J. Breeds-Taurima',
+'trini:bill-the-cat.bloom.county' =3D> 'Tom Rini',
+'trini:kernel.crashing.org' =3D> 'Tom Rini',
+'trond.myklebust:fys.uio.no' =3D> 'Trond Myklebust',
+'tvignaud:mandrakesoft.com' =3D> 'Thierry Vignaud',
+'tvrtko:net4u.hr' =3D> 'Tvrtko A. Ursulin',
+'twaugh:redhat.com' =3D> 'Tim Waugh',
+'tytso:mit.edu' =3D> "Theodore Ts'o", # web.mit.edu/tytso/www/home.html
+'tytso:snap.thunk.org' =3D> "Theodore Ts'o",
+'tytso:think.thunk.org' =3D> "Theodore Ts'o", # guessed
+'urban:teststation.com' =3D> 'Urban Widmark',
+'uzi:uzix.org' =3D> 'Joshua Uziel',
+'valko:linux.karinthy.hu' =3D> 'Laszlo Valko',
+'vandrove:vc.cvut.cz' =3D> 'Petr Vandrovec',
+'vanl:megsinet.net' =3D> 'Martin H. VanLeeuwen',
+'varenet:parisc-linux.org' =3D> 'Thibaut Varene',
+'vberon:mecano.gme.usherb.ca' =3D> 'Vincent B=E9ron',
+'venkatesh.pallipadi:intel.com' =3D> 'Venkatesh Pallipadi',
+'viro:math.psu.edu' =3D> 'Alexander Viro',
+'vojta:math.berkeley.edu' =3D> 'Paul Vojta',
+'vojtech:suse.cz' =3D> 'Vojtech Pavlik',
+'vojtech:twilight.ucw.cz' =3D> 'Vojtech Pavlik',
+'vojtech:ucw.cz' =3D> 'Vojtech Pavlik', # added by himself
+'wa:almesberger.net' =3D> 'Werner Almesberger',
+'wahrenbruch:kobil.de' =3D> 'Thomas Wahrenbruch',
+'warlord:mit.edu' =3D> 'Derek Atkins',
+'wd:denx.de' =3D> 'Wolfgang Denk',
+'weigand:immd1.informatik.uni-erlangen.de' =3D> 'Ulrich Weigand',
+'wes:infosink.com' =3D> 'Wes Schreiner',
+'wg:malloc.de' =3D> 'Wolfram Gloger', # lbdb
+'whitney:math.berkeley.edu' =3D> 'Wayne Whitney',
+'will:sowerbutts.com' =3D> 'William R. Sowerbutts',
+'willy:debian.org' =3D> 'Matthew Wilcox',
+'willy:fc.hp.com' =3D> 'Matthew Wilcox',
+'willy:w.ods.org' =3D> 'Willy Tarreau',
+'wilsonc:abocom.com.tw' =3D> 'Wilson Chen', # google
+'wim:iguana.be' =3D> 'Wim Van Sebroeck',
+'wli:holomorphy.com' =3D> 'William Lee Irwin III',
+'wolfgang.fritz:gmx.net' =3D> 'Wolfgang Fritz', # by Kristian Peters
+'wolfgang:iksw-muees.de' =3D> 'Wolfgang Muees',
+'wriede:riede.org' =3D> 'Willem Riede',
+'wrlk:riede.org' =3D> 'Willem Riede',
+'wstinson:infonie.fr' =3D> 'William Stinson',
+'wstinson:wanadoo.fr' =3D> 'William Stinson',
+'xkaspa06:stud.fee.vutbr.cz' =3D> 'Tomas Kasparek',
+'ya:slamail.org' =3D> 'Yaacov Akiba Slama',
+'yokota:netlab.is.tsukuba.ac.jp' =3D> 'Yokota Hiroshi',
+'yoshfuji:linux-ipv6.org' =3D> 'Hideaki Yoshifuji', # lbdb
+'yoshfuji:nuts.ninka.net' =3D> 'Hideaki Yoshifuji',
+'yuri:acronis.com' =3D> 'Yuri Per', # lbdb
+'zaitcev:redhat.com' =3D> 'Pete Zaitcev',
+'zinx:epicsol.org' =3D> 'Zinx Verituse',
+'zippel:linux-m68k.org' =3D> 'Roman Zippel',
+'zubarev:us.ibm.com' =3D> 'Irene Zubarev', # google
+'zwane:commfireservices.com' =3D> 'Zwane Mwaikambo',
+'zwane:holomorphy.com' =3D> 'Zwane Mwaikambo',
+'zwane:linuxpower.ca' =3D> 'Zwane Mwaikambo',
+'zwane:mwaikambo.name' =3D> 'Zwane Mwaikambo',
 '~~~~~~thisentrylastforconvenience~~~~~' =3D> 'Cesar Brutus Anonymous'
 );
 =

@@ -902,8 +918,8 @@
     my $in =3D shift;
     my $key =3D lc $in;
     # try hash lookup first, return result if any
-    if (defined $addresses{$key}) {
-	return $addresses{$key};
+    if (defined $addresses{obfuscate $key}) {
+	return $addresses{obfuscate $key};
     }
     # try matching against all regexps in listed order
     # return result if any
@@ -979,10 +995,11 @@
 {
   my $log =3D shift;
   my @cur =3D @_;
-  my $re =3D qr'((http|bk|ssh)://.*|[-a-zA-Z0-9.@]+:\S+)';
+  my $re =3D qr'((http|bk|ssh)://.*|[-a-zA-Z0-9.@()]+:\S+)';
   return unless @cur;
   return unless &$indexby;
   return if $opt{ignoremerge} and $cur[0] =3D~ m/Merge $re into $re/;
+  return if $opt{ignoremerge} and $cur[0] =3D~ m/^Merge$/;
   $log->{&$indexby} =3D () unless defined $log->{&$indexby};
 =

   # strip trailing blank lines
@@ -1232,11 +1249,19 @@
       $address =3D lc($1);
       $address =3D~ s/\[[^]]+\]$//;
       $name =3D rmap_address($address);
-      if ($name ne $address) {
+      my $havename =3D $name ne $address;
+      if ($opt{'obfuscate'}) {
+	$address =3D obfuscate $address;
+      }
+      if ($havename) {
 	if ($opt{'abbreviate-names'}) {
 	  $name =3D abbreviate_name($name);
 	}
-	$author =3D $name . ' <' . $address . '>';
+	if ($opt{'omitaddresses'}) {
+	  $author =3D $name;
+	} else {
+	  $author =3D $name . ' <' . $address . '>';
+	}
       } else {
 	$author =3D '<' . $address . '>';
       }
@@ -1300,7 +1325,7 @@
 =

 sub selftest() {
     my $rc =3D 0;
-    foreach my $address (keys %addresses) {
+    foreach my $address (unveil keys %addresses) {
 	foreach my $ar (@addrregexps) {
 	    if ($address =3D~ m/$ar->[0]/) {
 		print STDERR "Warning: address '$address'\n";
@@ -1317,7 +1342,8 @@
 # What options do we support?
 my @opts =3D ("help|?|h", "man", "mode=3Ds", "compress!", "count!", "wid=
th:i",
 	    "swap!", "merge!", "warn!", "multi!", "abbreviate-names!",
-	    "by-surname!", "selftest", "ignoremerge!");
+	    "by-surname!", "selftest", "ignoremerge!", "omitaddresses!",
+	    "obfuscate!");
 #	    "bitkeeper|bk!");
 =

 # How do we parse them?
@@ -1328,6 +1354,8 @@
 # set default options
 $opt{mode} =3D 'grouped';
 $opt{warn} =3D 1;
+$opt{omitaddresses} =3D 1;
+$opt{obfuscate} =3D 1;
 =

 # set up proper environment
 $ENV{PATH} =3D '/bin:/usr/bin:/usr/local/bin';
@@ -1460,6 +1488,25 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.93  2003/04/03 10:48:46  vita
+# added 9 names for new addresses
+#
+# Revision 0.92  2003/04/03 10:33:20  vita
+# move multiple linus' entries into regexp one
+#
+# Revision 0.91  2003/04/03 10:31:42  vita
+# change ignoremerge regexp to cover hostnames with ();
+# hide lonely standing "Merge" with --ignoremerge
+#
+# Revision 0.90  2003/03/31 11:24:32  emma
+# Obfuscate addresses, in script as well as in output. Output address
+# obfuscation can be switched off with --noobfuscate.
+# Suggested by Solar Designer.
+#
+# Omit addresses when a name is known. (Switch this off with
+# --noomitaddresses). This fixes the "distinct changelog per address
+# rather than per person" problem Sam Ravnborg reported.
+#
 # Revision 0.89  2003/03/28 10:55:39  emma
 # * Add one address.
 # * Strip $0 down to POSIX portable file name character set and untaint =
it
@@ -1808,6 +1855,10 @@
                      abbreviate all but the last name
      --[no]by-surname
                      sort entries by surname
+     --[no]omitaddresses
+                     omit "email address" when a name is known
+     --[no]obfuscate
+                     obfuscate "email address" in output
      --[no]ignoremerge
                      suppress "Merge bk://..." changelogs.
 =

@@ -1906,8 +1957,6 @@
 =

 =3Dover
 =

-=3Ditem * OBFUSCATE ADDRESSES (requested by Solar Designer)
-
 =3Ditem * --compress-me-harder
 =

  To merge
@@ -1919,8 +1968,6 @@
    o iget_locked  [1..6/6]
 =

 =3Ditem * Integrate Bitkeeper
-
-=3Ditem * See if the map can be made to use or accompanied by regexp.
 =

 =3Dback
 =


##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.46
## Wrapped with gzip_uu ##


begin 600 bkpatch13496
M'XL(`#HZCCX``[Q:VY+<MK5]=3DG\%*G:5Y$1-]=3DPT$EQ*-%>-;I9+E[CB)$<%
MDF@2TR1``V3W=3D$?Y6#_F!_*4A[,VP&:3/3/6^)Q3QQ=3DIAGL!!/9U;8!?LX].
M6OY5*>HZ5\)%0J=3D6RM'7[,*XFG^5E5=3D12K^^,P:_/G2-DP]GTFI9/#Q^A?_&
MX9=3DQ;4SA1@#^(.HD9W-I'?]J)]KKGM3+2O*OWIT]__CZZ-UH]/0I.\F%SN1[
M6;.G3T>UL7-1I.Y9)776*!W55FA7REI$B2D_=3D]C/NY/)+O[=3DV=3DV;/#IX\GGW
MR:.#@\]R5QX<)/L[(CY\?"B3W=3D'6?IZ%?0RGV9OL[3[>V9E,)@>?#PYV'C\>
MG;*=3D:/\1F^P]G.P_G!RPR3Z?/.*[NW^8[/+)A-T\*?O##AM/1L?L_W@+)Z.$
MO8VGC4M$+9E(\4KGI(O8VU+53)9"%>NG;)%+S;0H)5..S;19Z`BCQV.5:6-E
M*6T&25E9,\<ONL8DW\O%9L[1*T8*>#+Z86.4T?@W_C,:3<1D],>-&G)3RBT=3D
MN-S8NC!94`%>.3G</]QY_'EOY_#)P>>I?"*FR>'DB9C(5,3I+0H?S+(WV9\<
M8*Y'N[N?=3DPYW'AUZUUHC!I[UOU[/;5XU7,_:J?8_[^_O/SKP3K6[^YN=3DZO'A
MA(T?[^[]OSD6NZ\T<XE55<V<:6P"F4Z9:>JJJ;\E?WJ_4(AD#K_2QG03N*:J
MVAD"MO/*-489[X[T6G+=3D@=3D.*+;=3DE]S_D^$44SC#OMX[!8:W"WU-K2E;G$O,X
M&E,AQQC-8KPQ5=3D.IM`#VMJ-T;9C1TH]?7M\`EK(!3PWVVVU@$%QX3'I(Y52*
MVOE%*9VU&SI75YSE"@;[KS>TVF\87I$/(R\@@Y78:Z4;=3DZ\WM]]5H5P-,S,K
M,WE5M7,?I2E[PC0"E53D(D1I\/"W;&P75_3?^`HANW:__T'$GN[LL)W1"__G
MU^R;%REGQ6R<^*5BQJ@J'LS9)'JRQ\BUO0/OL9T)WW_,D2?GT"`[NZK8-Z,7
M\-:=3DT5_9O<Y7[T>__UOT[9\Z5_T;^>H]]O2/[)[7`?O0(N\]8']_@`EVV<[N
MR#5QYS;R_K-OV3]&C)5+]DRPI^S9I^_H-U&Q?[#:/GSVD#]D_X2(GEI9-U:S
MA=3D"UL%8LV9]H#&??B+]._O[=3DZ)_?C?[F)V_T7*KB"S-SS/V;9CX]?((,.AF]
M>+3[&#\\&MT3L16Y*/ENNI=3DBY]%*A+T?A>=3DL+C1<RC)XS4+>>T`#7-$DRO!:
MXBVDK"BVK;[H.7LC$B4+#TV>[,,(2!RQVFCUJ(BEK=3DD)%`YO3@,P1W&GA-&4
M2"H!]UP:F[$C$K48954B>%VGD99U`+T4<X75';7"`"PECZW2/S<R-9$Q4>7:
M-UL-0QIV(LBBN<'&L*_"=3D*,2A&%2J_EP6U\<EN9)M?/D,.J&WV5<8VOEN-&K
MOF8*9)H3+_&@%(:A$,_!<2)=3DUI%,FQ8*$7LGTJ!!]C7+C,D*V8[Y#=3D!EEJ56
M.%7TED$#7D;LG4KRNE5^*JI".%Z98J/[(R0NK;1AIUX8<*K(8,JD:!R&3EUO
M5BH;PK%3C_!@&5N^\%:7D2XV,$JB9Q$[MJ99M-",*('E(JG47G1?0]'?=3DO@E
M>^ZEUX&7TPC951:#56S@I(N&LENZ&9C**RP\"K\972@M;QF]&7-7<",U)V+:
MN?A:)\])%(O.U7,!70MER?8]?2-J+D2K:`_1TC@SK7OO[$.4V-WAB2@CD43-
MK&<S=3DE34HA*8?F;F?2@R1[QEW]NP#4Q[IZDOC<L5#^P[2N!J.54EA/9ZE&(O
M"=3D(#NUP61=3D1H=3D16;J[Y"^]`9+YNDKTG%7A52ZE:XK>>!M"IYJC)IMKQSP=3DZ@
M0ID-:*4JGPE$<RO*FDH6.]P:&(]</K)V*Y)>>8C2WM^*.(TQK!":%U=3D00C.#
M_IJ&]+%1)*3LQ%SY%Q#2RC07?2L/`/**.Z>B>*U0/``/H*18"RU<:P8\_;10
M1:%$"3)R/2?+*_9C)QXL=3D3@PKWY]5)=3D<ULN(*)S)\9?:5&[IAL/#2M]YR'J=3D
M<HG:DN3:E`*T2NEDZXT?(`@>7DRMY"I.([G.\/0$*?>]T)?-+V'&,K[:H4BY
M;IEC68AEP#3:K/B\7`@KMRL5*AI)/8Y62YM)3"HK(^N-'Y]9-6-'K7R#S?CD
MZM%>I#<.A(?L.;*CF#IGULA2S21'2*FXW+S^#1ZV4PY-XK/&39F$'=3DG$4R+5
MS@MOC1;&I!Q%R2;Y-7__$;(U%#9`R?,IER<+]:6,C*?&\435*FI*5(I>P:'$
M1PK>[`]:C2WX#*;635&,T3OT,D!J_X6IO3C@,ZC"B<62\K$KHDI5<I`'((>)
M21[P,[M$$D9X1Z6:1E469:D`)]S,OY*7B,/5TJUJ,S4+E;3F1!AS</18])=3D#
M:>P8(09ZV=3D(3BTH-HI=3D+E,JB``/JP2&K9</>$]TV[)U9@4?.%`@WJG88?'E3
M"-/3EERQ/[<>0\_F=3DX3JE-,?\<8#\!L\VF:ET!M,W#X8IUAX:NSTU_$QZM_0
M"6^`-3IR.:5XOEU<(6+OO<@CG:JC653BS2J970-#REY%H(M>[/T[7L)*T*?"
M9G^0R*8.LZ`(@,^!VKK(=3D\9M*4G;;/E2:L>."+15T/TX5%2Q'M'9K#]D#1Q$
MTQ9@)<"%>8;^#&2RF^6-`$_#?I.\D&497!$U/$'*YG-0G`BI2/KRW`TY]JW?
M<0`%?('@@G+`VD6*V:<MYSQM-"*9\ECJ6B#\3IE/*9S1<%GVDN(I/<*L`1'0
MUIK%I_22+T5N>F7N-")B=3D^S%:^!2@]8-"BW)EV2;[^'SHI]Z@*^AI<@E>;/$
MGGF%!1JH.);=3DT)J=3D2M**!_B7)`8FU@Z^%<.R/740VPVR@+,%CTW<FGDNDMD`
M>RE*Z/NUN!#*R6[`=3DKC<"H3QP!CR")V?@26C+P_LNU.<P@D76.JL-\(VB630
MZ1GV8.KZWH.OOF:JON?H$-&P%V\NWH:!^HL#"1>4>C>5HL6O%584_AY[C77$
M[=3DA2`!T'F=3D^&;]Y3]$K4.A7(RS2%SF^G99TR+M#E(1J2O%1I6">-6]%1R;;/
M_MH8FVEXRQQ+'*87'^4^O^CUSJQ!9IM!8<U5?SU64SI&@D5]G5DA]:H=3D,)5:
M2R2CJ2C0@$6)0VB(`IW*<E.2R-/.`\Z/07BZ&APPU77:#-S,J^XYB3V0WNEX
MK++*:-]V=3DESPV(H47-NV\9F+N70Y%W.Q%#U#A\?LAPA-TCP-+\]1Z6*D2EAZ
M68FB[Q8T92M=3D)\1<E4X64XR[-%9'@580$Y,VB222!_T2N;6S7/[;ZI8T#"G9
M@[4OLW^OYUIX8B:N5(^4'9.$_;CF8Q[X"7P\HWZC3_X"\")(/!0]8)*#QZQ_
MV(.ND,OUT.+0@Z3RZB%A7".G17/%9V8ZE8!W?OS6S81E;9/4DHFXI#JLE[QJ
M;(J^<6/B0H`NO0G2`16-#6J*JF<<'7#=3DD`TWFR`1>U'/J.&^I0#%5J!/OJ&C
M;7V7Q'YE5M8UCT4Z=3DA5>U-<I23!?Z>EDV(95.1(VKQ)%G'@K=3D"\@&F[!EFAW
M;)4ON[H7D&_\PS"C6>AI`:IGK4I5SPE?P?F/O53)PA.:N-'0AAL<MQRE(6M`
M%"#+FB(]T\TF.EY3""$;'0>A#,B%N$9=3D0X([0D4*NT67GQ:23\$!>K'6D#;8
M]Q%Z"!)[Y$K*>$S'C([[/Z.5B*%3L^KI*/AXQ'X"ME^<5JL5KTO?UH`OVC4=3D
M'?0,R3B-<K356`K5Z#8!TH'T>'+(Z5"[>\^)L,7X5&AH#199#_G")#_OWVT2
MK+J+;%!+4".P1)?U>K)W#:*U*-A)*QTX!!A$U=3D3(E$7=3D>U=3D.WGSB)7Z9LKB1
MH)_DR'GLM6Q/)A*J"&!812EZ<]%#]MSHU2^%7`W?G2,1%%$_&?@WUZ8"W6(7
MICM=3DN2F<B%47:#46N:HE'T[B)>Q'DOB%Y<@Y23F-M"TB+>9+T/NBP[JN]>RP
MA4F:FDXF[CH&"1&\EM?]4O,>W2",]3YB)ZT\8*D)^'FA[-76MFG*-CD%$##R
M.LBJ+*\[$'3!%TAV"LU:E[Q/6@G2;Y!L:G=3DW=3DMX.]ZJ."HD^>9M8]VWQF@#^
MI:K:@W_CKPCYPJD9':^,%XVT*U#K;,-\Z1Q#LU=3D@@*T-MU\_:V`CP>DBR*J5
MT:+G5U:HC+WR`/_2@F[Q8!:1*J3[[B4GX3F(EG\>H`;=3DY&7N_][LY25=3D*+`+
MF(*>LY<V\F"0C"4J+R_GV&DOTYT8*Y?L39!Z).(N1Q7BH+$IJEC:Z]P0F5`V
M\D^`>+A!LD=3DS7U;H!NQ<]G/H7/DLZM0:"H;",Q6C&4SS_K0D8,])T.(JNE>^
MWMW3?1I:\%,3K[W'V%C6O%CT2N!+*)@X.'@R"5N87<ZNS1=3D6>$+"%E4CQ9>^
M6^TK"%S2-%GKU/@IO^F$">D24P6A!U;@?(VE+"(4(JKN)Q-R[PMTO>TN+#KJ
MFU(#J!M-%^QB85A[N>VZ+V5,_<F)EP9<(YJBYH>[^]?RQ/@L-8VGA![CX6`;
M*26]IMI*3R!6J#,?O-@CFU@EO%12=3DG4"^9;.U3ZBKHB9LN'<+%GPZ60R[9DW
M1+-,LT5[=3DI(LIL/$O<YCYTW9N)"(E]+DVP<-_3C]"^0$3"/*/71,0NF73G;S
MCC6IE+WY3]&>D:1[HLD:XK"U1&,!+@&-N6T:Z"%KYI2*\=3D6P-J$LH48;K8(8
M3(374M8*O42ZU*#RR2T,#LAP3WA3ADA%(:.I0+^^P*/\6I">0L[..WEX-Y&#
M[M%&1[=3D@DYGB<'>'+F0\1TO=3D6.GZD>4;\],`O&%,)++;D3I:H5<;%";2TT\J
M\"(`KO6Q;7E_*9`_S$+5JQ8HH@*/D&1X):W,[.!Z`(,$,J"7M_CD!EVU![U0
MLP.K82?OSDY??'C/?$YA4]/HE*KLNC2G?B61Q1J\J3?NXU?XKEO;7/*?U<`5
MYD2>%8BJZ!!TX(5R:1:NOU=3DRQ%/_>`V\].>AI=3D$SN02R-R/2EW2WP+*HN3MR
M=3DCMT<')S$Z"6M15)7H#KIW)P>70=3D7=3DY\8A1V#4KP1G41Z-$M,)[%JG8#=3D=3DZ,
MUPW!X$OB#N!*K5+Q173_E"*,V\[F-[]`I>,8+6@2TV7+UO2^79!%T4';8X/M
MDZ*`_EX678[![U05J2=3D-K:EB*6R$X:+I#WBNXOZ`3Y>2/HM8<KIFK&6R/?_+
M(.[PR/!7=3D#7F:[3=3DLA)]NA!+O5(=3DO+Q&5]ML:AP=3D3/04`OL(=3D.0JNON`6E$'
M<'?\`NMNQ)T'.+XT#7UQ$N%ONMJ/0.W[1DWR!9+8D*"G<6L^3C0&5<%_)8/N
M-Y._:NC4U1;YGZ,JRD%V8^^]H*7"'6Z;@EQ'XJ7-XO):KTX&9:?R',(`TS4B
MWBTC%V=3DTI2C"&G_W(:>V#1,#<`_>:PM_1_H[/V8.-\!&4[,)?@-BJ&:TJ11)
MJ\WH2/HSGJ0HT*MAUJ?^)R2[X+#;!?J:K^:@#X[C-Q3&+3U>*']0VS=3D"3B>;
MCE-(AA^WSD`N_,,PL5G`!G3'4,9(4C#3S2%\$7"#,5]&JDH@@_CO*X;F:@7L
M_?K$/E46C<%T2F?]7)M9_Q3A%#+V,<@\MI#^DP*TH*#Q.H*%KZ\:%!(]2+K^
MSJ,;L_XA0HEI?^S7F-N&30OCX"7>]G=3D_V9>!*,%S:E2N.[2/L2#UT#(!O[T!
MAN*9@+8FLW!LEIH9AS)E4D_CWKZD!G=3D\6R@XGK\6K@*VR3)>&_MSTP]//"WH
MTP#E+R$]T,H*1.+:?CX61,S9:1`')+V"YPW*YV5%?;`3409&VQ[.+.F@)PJ-
M=3DB[%\+,0I.T%':8Z^26&0T`MYTM-9BR_A';B2FIQG>)(68D9?)"D'NBO/B)'
M5Q^<3ONB9ERY)KWU;B1=3DE(M=3D[O^,8K&LP41!M*BUH`]P^I:DZ\[<-.%2(`Q3
M>FI%"AULQ_T-V)M#;0A<\<11;UTCV.IUOG%.E?293,%^,G4XFP&%E*FT)2J9
M<IZ4=3DM.>P9SL.(A#'I64T+WEG2J4U(G<1GMY']JX'F?8QB0I=3D[,EG82N+QG.
MTE2!749H#L/)MTSG4'YBS?#FXBQE?P91E0&"TI-^HH\]$=3D`M+*H7:R1)V0^2
MN@2`IR;):PZ>@F5MOMLX\ZY[3C*/4C/9?JG-W71<]Y#O3#%E9W0E?BQ;VN/H
M-JU_1$[#>8R(,5%P'*W&E*]RJ<I;)\*P`N&-(.>E=3D`(=3DV6:[(?3IDBKL6&>2
MCGEOS@!GK;0].D=3DQT6@3./Q+SXIK%?]]_:\*+12&!5Q_R-VP*&M"@!SWS3QC
M1U!>6[`(\BD7<:QT)@8=3DC4=3D>M!(/78J"TQ^1+)L^83O#,R3+&)V`AL_TCEN1
M(F814LQT2E<[KFZHC'N5UXVDB:7N=3D'X.++MHL?2^J5"S9IDUEM<U^2']7]LU
M&(O[2$*/C(M;OLL[+WZ9T\6G;;3!$A%R:SK<9K(I42@4;#7X]..<[$'7,:'X
M3F6A*KE(;_B>\=3DR+``4)H8O5<*))KL;NIXA\;6HFW(P^B%4Z*:``^NR7_1A]
M2]/J+`?16S;;AQSG0<+^T@P72Q=3D?;E5#4T0HU[<:8F;T4K%S^FHX\>M%!J@B
MIRG9<\2G-JZ+XG.2L?=3D>%K#.?UGI+]/&<2.3O'_+_1\00DW?=3D9P'G!]22#JM
M$JAE@YN2EC31[7&ALO_F['J>W+:Q]'W_"E;M87>K5AR[/9/*\&:OXVZW6FZ7
MNQ-74E/E`DF(A`@2"D&T6OI[9PYSF.O6'/:PWWL`*9)2V^TY)':(#R0%`N_G
M]UY*#S5)N\Y^O+@XRLYWY&5!.-^8TJS7`457H"*@$Z;QAQY\7ZKSL<YU4R=3DK
MQ]+15:T=3DR]X/*JNP*GE6*O;+GR5>UJ:"@K9MTO\EAIKL8)GU7!>6#>_\($_`
M7CG$%H9G+Y6T<-@HQ-6;[JA#=3D`?4=3D,YSP!8F0PXMVF$["A-OP])\%$X;3GW]
MG6$N%:=3DVQ[781[_`97!M^""[!&=3D0IK%L]D>KN%_ESQ""X8"$`WP0A4E"A.?T
MA/R&T<D.+2C?"^4-)ZG:NVU<J\,TZA7]:EQ3+*Y8P0&=3D"[U.=3DMH5E&GL()3[
M\%2_F8R5`PL*>$J@=3DNZ1)/##(PQJF)_X/JH3(]/YDF%00M#:^&<CQI._$_V]
MSV@U]O0TWK!T;1=3D=3D^A$&0:5TX;S5/_PXRBQ?T@C$6H<=3D41I2*QY/7MF)4<3<
M9R)_'8:<$R/AH\`CPF[9F;:R,WST054FW]<>W19);:"-O&4QR//+5A;1SW33
M_K8`6KB]!7GJQQO.8:4Y)'9?;T6G,A-G@>)\B<N:%-.]<36[6QP13R@#Q$9H
MG'9PY^9N_37ON>@^/L;)_3R;656X_3>0;!%#8+<RA2P:&6XMI]DAF9DA.3*=3D
M"YW`_ER(HV2X=3D+*A[1S=3D*%&5>-\N^(O8ZI*RGENEBQ:&Q?@+XB-3@N%&RM$Q
M*IH4/A#T\V`"3=3D;Z#<Z2?V^#S=3DVFQC,;L(B;;8"9Z!YJO7"9I[86T'8G9_VC
MZ"#+E(@NG2C*L'E,9^IC-')T0R(MPN9O</+/R=3D4";PN/6ZSE*&;U/Z;=3D1Y]%
MUY]'^/&B38D5G$LMB)$YX<I$EPSHH4TBFB(51)*@G,V8YWFKL0QO6[B3S1'-
MJU"2P]0.$?BSP&?<KDBJUHARMGN7=3D&UQ!5$3K&A"5N53(;NGYI@&#X*`;O,'
MBNC.C^@G'O=3D01UGL]B3[<`EQVA''FX<'Z+X^P_C,2@'/B;$<[RHLOAQ38K2K
M2=3D5+ISI86=3DMZX+Q>.H[JP<&XB_$ZA.:9'1U)J*`M19A'O_/TR.YD29[&-(LQ
M[/;/?I20)0Y,DNUQJIC^W6NA6E!N&V?I#F>@]D`<+GWR^Z[H,I46Y7X=3D2DA7
MG=3D-IHUCOZ*A=3D\0`>K7UPG&@TQ!,Y;WA3\LF?B!*F2X:9%,/-)UE52D!=3D2:UW
MJNB!5+9Q\?(BKF&S8G//<CA/3#H;'GX2?<:[?!*K1?KJCZ^^[VVT[;[].^&@
M=3D6(--4Q.\?/?QZ9Q:O-0U?`U^!.)?K['MW]%H!:ML_@K["(\(C?2-O_1<7U3
M],\__(VF-@W4([PV)=3DM%03GS[C`LQY4?C58\>NE'_1.;5OWNY$5<&#A`V,^9
MQIJ,),Q50$27!!C/>2:XA<CZGBAXJ5JSIM/*!1];T5;>]AXD^E4`1+>%V`E>
M#TH#PRF2^<0#+F%WPP-N4F'+L6BGG/0=3D27%_[K8BF=3D1FAJ?$_N/![GCP,HV`
MAWUGVJ^"7''&]+K"U>@MK/3`[E29N/C2V22S#S'^SHXBG,:N*SRGU,\B5X`D
MF73KF3.'K6MP_%.=3DY3W:T_AM]/Z>Z-</*O-Y'$K?;5Q+49>,%S.NK1N4S'MB
M4B]-94NQ9X?63VB!J*M)=3DN@))$0SW"4-VS7_)MPTCBEA3H_BRN^)7T[7I,W<
M$9;1XD'*0YL?(^5GL):D\"8I3<>[95CP]Y9X`K=3DQ!+=3D`4.PEQ-.P=3D4J]MDGX
M<UCJ]TUA.">_]JMFX4EA7M(S+X?-]SZ,1"O7V:`SX(LW<-!S)1_\!"([S]Z'
MUN-R[T$T9[-H3.V(8"%Q;_;31G9>\Q=3DLD5)%'QC#^#B'KF.6,0R7=3DIRNO,:M
MW_I!1L*.\'9Y'^,GP%*$^V#T2RF(HWV:8;K&(!1(/=3DP).JF2EK]&[48I"Z;E
MT9"'52:%&L"1A6\_#I-?TTBTE'Z9@'/I2=3DSPFJY&UU+_H_$4N@U4:"&TIL*<
M5,M!M</;?DT,>3\6D%2F05'$6LM]`M4N\:<<WYPH,V]ZQ#`IR4PJ=3D%?#1>N$
M:N835F+?KP#^\TN=3DU9+*:T^W68!G*Q[O9^SC$D=3D]RA`EY#ZZHNL#+,E:C1V8
M?0VE9$+U!9*7XDC:IX'H!F9?_YZ-2H3E2B%LC=3D8,WTE%*XJ*]%\*,/7P]'B:
M;%).*XT>Y2C(2B157/8@05&UJ3J[IIPK<>F;_DZ%%KL$>G9A=3DOH891'-`N:R
MS%4&(Q`(C]6T9?GDX!BY\<[FST?#NY"7V_BLZEJT:^R#"86`U,@G5Q0J&'V;
MG"*@_.]XA[4AYL2X[H'2;LK3;CVTPAD9$Y;/0%RMXV_`VF>^7%=3D2+5)?DS!D
M]4.:[RH0:C8RC3>QIPA]DR%$J>-X1\%R-@.F&Y#>\O,PUL-M(K*,8K[=3D#'KG
M.NANSU$:W+N-Q!:A&A;L\;&X/W?.&.K@-\(J_3KXU"?CR32QB7'<GG>NR86-
M;<Q,XI.%(E,;'L$)EWB#C0SE#ZLN7QPI%L.>CNX,D?>]/4W8G=3D*Y@0WIL\B3
M_3_%0I$?5.5C:^W%$UDZ7NA+1HXGU50D)BHY+6=3D]`CPC(3R!>N:36U?'\)/K
M9ES-]P06+E7W#'"KZOKB-%IGR&?&T!&4^#_.LJQ&\/''\_/P(I7Z5Z?]KK;?
M,W5FQ5^;D@QSXJD25X%_3%"NI_')J6ZM.KA/6CD[@_CS'VSA#52/TUP@2](Q
MFU1D7@OJI`'EXWIJ^::&':PL;_^66$.3"$Q05@P9T.9YZ#.U/!NST%6M86ID
MU=3DI->#.!.'O7C_#3^%KB_QCM%P^]DMY\#BA+`F_.PWW70GI1#-L#B4&?OGCY
M\N+5GWY\^2I>V^`F](+TVDA:S+9)PXH;IIX1SWG\`24L>+[88W:0U=3DE$V0+S
MQK55C]!QBA_&!H=3DK)K?2P/%(0+;%EL(=3DDD+:,&=3D-T8P2#O_;%M%''O9H"A/$
M%+)VCXGJ8N>&"/$UCT5O>>P(ACB2;;Z6NIML2!Z)?O(C`4TT/?)WQI\(.S=3DP
MCP<09'5*?YEM<"K%Z?D!C-/<Q,%VHI`SZ-*'/`BU-3JYJ$1<JVTW.!P_/12R
M4?OHH]'[OBJ>P'!^3B,D?,<[C'A?E>KA$RZ*MX)"4&.@+:-5;[-9>$TDJF4Z
MVD%60J7Q0,#4$/<PT:2"Q*:SZ_OS/*BV<^+$PKOS\,G4,^&#I\&5.=3D3FC!8\
MAZW%(UD[,0R6KN0XZLP@.C?IV6]?)RZGK%H3SZ(,O-HK?-EP$N&K&5>T.%3S
M#.RUI#P5-&"K=3D']PNI,\[5G4GM*C1`K(VI$[04^^WX=3DLZ`:'JA&5V*C3HEIX
M1M&',!:PQ4)5Q/T_@<;O8Q^<!FQG%*R9A-G^>+J@("[Q'_$*1X'7L\L_,YCF
M50M+['!7$U-C$Z>JT":E\.'@#F*_*WCH`<5S8!_:;7L0%=3D;O\8^OAM)K>&!&
MPP_S@T]&BBJ!W4B?<QRS\`'O"L*>BNQ8O%0BUS)+V'8N#>15M88Z*X<?<Z`=3D
MOV20];JX$FI1$(V"\IO$"$N<,KN1?[T4BJK]CH`P*ZY%A3,'9[5BGQSG=3D*V.
M4U9AM$>W4E$"M<-&,].;?PHC`9G`:3(V[K8O(1_*=3DD%1D!2R?E2(]=3D0K)?_2
MI`>AIH?P":06R18F82LSYF(->XH+IZ*[@_09Y4HT9N/+F^=3D!T"4-$9<L$U-Z
MQE-]<,+=3D+,^85RI/[T90J&W#,9*CPEY*:F)UNPL"G3$38V4".,<8J<B\P!O8
M1-?KTW+*Y=3D]:&=3DW]M0VWMU"F>9(+G`"\PU"*M^2!Z*W;FL9_:'JL2[8"SBX5
MP=3D`MC[N"W^EGBH'W)005U=3D5U9;R+V128'>NE'XT^<T52XR=3DP,GIC]=3D2^I7@]
M;/X;6/?%"'?J35!^.>C"SO\XZ/9S1N&25NQ7$P+V58FOA"/1J=3D@:_*C^3+QN
M573M2O*MK_Y:2]D(W_R@HJQ8/@_N+OEJ]/J@#D?0%X'_3+X*RY)M'>_$[BA?
M^I8.Y.4(7W14*:B%$Z[C)U@X/!)=3DQL0W@-6/&7[O*WL0"=3D4GI;4<I`FEWK'Q
ME\HN[@XB'6?"H__$YU@K#>&UD(]=3D=3D'7[^?[VOW`C?'8]2P^'&B-\<[8(J]K6
M^/K)K"`/BYQ[81=3D'=3DP1@;(/?`0V*O6HT!'<3(AC,W7E//=3DK>&&W_R5`(`X6U
MR^+4OB0EYV-K1Y%-X]$]M,B^[Y]3F=3DI!E22-6G?[J;994@1NFOJO6O%(=3D-M]
M)ZU\'*=3D$VSQ:PB/RN\.C)BLP1U18^%-/@51""7]U2:,>2"&:A/\XQ-EFU);H
MQF4BNJ=3D"!3B-G?\Q+H6ZPE%6Q)]U(RKB$B/1;3"'*R=3D3J=3DO$!RI=3D=3DOP`GPSW
M)%LRP$,;15'Y1$$J!@K*\6W#8$21T<+YZ$;E#GA%?+`M?EO3$HUY7(&*@[ED
M1&C(T\/MQ7/07$&7;.V1Q,RU<UH\1)0SU![##.]G9--ZY+"-OP;M.LKMGG47
M]Q`T-.R!CII;P$[NJ&<5A'1/U[SQ(X15X45W1&;B^I)%WRK2=3D&)$,[P)D.BS
MT*%B6N=3DI@G]B,V8*\UYX(]I4R59Y5)VL\0Z9V!Y1U,C,%XKU3B893QF5^674
M(>?X6"EA:]ER%/[14A7P@"F!TDR"5C<TX/GS$_B#H5/K^Y>*=3DE(GQ$;?#2'X
M'=3D:&^JGMQ];TC5,V>A=3D'MVWGA1[[P,^AN7M@2;U*\GB3N4DD'":N#S1K[&-R
MYHRCSC?0]]T/Q^_$8Q`JKE]QKL*N<R7+8SBS)\_310_:BZ:@_/A#G#WV=3DZ)K
MT14G+'2=3DI*JC%6G'WY<ZC*RR7PP;=3DIIHVA/%?=3D?)+3G`-\$'TP8K$Q]*1P\;
M&!0S17E#H.@W!@V3*MC>,G:-W4U,7X_]U2V6RD7+G0\F:+.3E:BW9*[OZE%O
M`2YG?P/%&@#C+^Y2\MZW%$\<Q[5OZ'IT[U1P^33DS0.,&LK&-^T^JQ(I[(2#
MB\U,Y-KH=3DH!,'I,)^]">[[H(146%GU*)Z!>EM8#5*:9!/^V:`Y&ZC=3D&3>!_'
M4VXP2*^(PQUODYW1U6+;FHW,NO%GSQ8^@7NTW/W)KP4U*<,:X+V@*`>;@*8X
MRU2<'I@EM=3D3<8^O8A:CV/7340(Y@UG&20S#.&CEQ8\D-F4&?S&$?"O:@`T23
MGZFNQ2J\;D*Y*5&FB/$U%V$K?SVZ"S60P%'_L(0"%^W:::W6<H*FT>ANV\)Z
M"GBJ+5$V,Q,8#N<GF&"BQ^#1!U&G<KQ95WR=3D*@!+[+[^\0UDXOY,;2^9C*LP
M[*$M%C,EA2".RTV'MR=3DR$@+*&'X2<5E&4FC%`U1^TOE:CG-VL9]MGF#>^EL8
MN+J6>LP<'V<2K!`$.=3D$$6UJ324/,DVGCTK7^!EOL]&K_W#OX>8Y"$X7H)A^+
M=3D]^=3D:_(^3$D&0E4G`GM05K.=3DA1'6I$)72O;]P3"A\M0NJH?-QZD4S*AH)ZXR
M&-%:#_L,$W"//[]X\>([II2)L;F>(:\$)*:7-8PB_4MTMW.5Y"?47(^'WG!:
M'2VG`'Q#5ZUPPSXA*!:E&_=3D>.7:W@O/D\SRUX"(I3K-..!W$-3/AB'?=3DE]S4
MEN@U%-`9O61'E><UU_N?WW%<#T_IAD&1]#7RGY7.?+O#61?JQ'>A'J$QYCO&
M>(J>R/,90Z+&#]>V%`5);1)G8U(7Q60/M)*K(\H_]K%*?G?48:B>K'QE%75X
M%+;9<]^W_8!^4/`))Y[W6?1I(F@T^_E/3!,#+X4BCXT<N@VN1$$-C-_`>_._
MPN^?YW"[ZVP;6*QV#VU4RV=3DI@IQZORV(Q)G@9R_@<>8+0;G4\;X*;0\(.IKD
M;/J]<[X#+[,$"^Q&O5)ZJMU/6F'AR+VF]B"4&?<3E+5<UC#V98),685!!A))
