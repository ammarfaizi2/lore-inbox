Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269842AbRHIPZR>; Thu, 9 Aug 2001 11:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269840AbRHIPZI>; Thu, 9 Aug 2001 11:25:08 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:45818 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S269844AbRHIPY5> convert rfc822-to-8bit; Thu, 9 Aug 2001 11:24:57 -0400
Importance: Normal
Subject: Debugging help: BUG: Assertion failure with ext3-0.95 for 2.4.7
To: ext3-users@redhat.com, linux-kernel@vger.kernel.org, arjanv@redhat.com,
        sct@redhat.com, trini@kernel.crashing.org
Cc: "Carsten Otte" <COTTE@de.ibm.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFA546F20C.78C10EBF-ONC1256AA3.0052D4C2@de.ibm.com>
From: "Christian Borntraeger" <CBORNTRA@de.ibm.com>
Date: Thu, 9 Aug 2001 17:24:05 +0200
X-MIMETrack: Serialize by Router on D12ML020/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 09/08/2001 17:23:45
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello ext3-developers,

Just to summarize, I reported a kernel bug message with ext3 on S/390 in
transaction.c. I was able to reproduce it with a ext3 on LVM  and on MD.
Tom Rini reported a similar problem on PPC. (both big endian). I have sent
a backtrace and with jbd-debug set to 5 I was not able to reproduce the
problem until now.

On S/390 there are some more debug possibilities. I would replace the
assert with a panic and make a complete memory dump after the panic. We
have a tool which is able to trace into the kernel data structure. So we
are able to get the values of  kernel variables and function parameters at
panic time.
The question is: Would that help you to debug the problem and what
variables, function parameters are you interested in?

The more interesting part:

I realized that an  ext3- file system which caused the bug has a state that
make the bug reproduceable with  rm -rf *.
Futhermore  I was able to active the jbd-debug feature and the bug still
remains. :-)

This  is last part of my /var/log/messages: (mounting the ext3-file system,
entering directory, do a rm -rf *)

Aug  9 17:57:31 boeaet34 kernel: kjournald starting.  Commit interval 5
seconds
Aug  9 17:57:31 boeaet34 kernel: EXT3 FS 2.4-0.9.5, 30 Jul 2001 on md(9,0),
internal journal
Aug  9 17:57:31 boeaet34 kernel: EXT3-fs: recovery complete.
Aug  9 17:57:31 boeaet34 kernel: EXT3-fs: mounted filesystem with ordered
data mode.
Aug  9 17:57:39 boeaet34 kernel: <79): journal_dirty_metadata:
journal_headion.c, 1069): journa(tra journal_head ion.c, 1069):
journal_dirty_metadata: j 1de27ec0
Aug  9 17:57:39 boeaet34 kernel: irty_metadata: journal_head 1de27f20
Aug  9 17:57:39 boeaet34 kernel: <n.c, 1069): journal_dirty_m jou):
journal_dirthead 1de27ec0
Aug  9 17:57:39 boeaet34 kernel: ei.c, 663): ext3_orphan_addxtet_writopy 0
Aug  9 17:57:39 boeaet34 kernel: < force_l_dirty_metadat7e90
Aug  9 17:57:39 boeaet34 kernel: <77e6transaction.er_head 1de27f20,
force_copy 0
Aug  9 17:57:39 boeaet34 kernel: <7, 525): do_get_w ssaction.cn, 1069):,
1069): jjournal_stop: Handle e: Newandle: Hl 117, free 714, 52ef0,
force_copy, 1069): journa1de27ef0
Aug  9 17:57:39 boeaet34 kernel: <.c, 695):
e_get_writournal_dirty_mr_get_write_acourn_get_wournal_dirty_mee_
5transaction.c, 1069): journal_dirty_metadata: journal_head 1de27ec0
Aug  9 17:57:39 boeaet34 kernel: <de27e60de27ec0access: buffer__coa_copy
y_metadata: journal_head 1deext3_orphan_deansaction.c, 52getn.c, 1069):
journal_dirty_metadata: journal_head 1de27ec0
Aug  9 17:57:39 boeaet34 kernel: <7r_head 1de27e60, force_copy 0
Aug  9 17:57:39 boeaet34 kernel:
Aug  9 17:57:39 boeaet34 kernel: <7ad 1de27e60
Aug  9 17:57:39 boeaet34 kernel: <7le: New handle 1e70this_handle: Handle
1e701240 given 108 credits (total 117, free 7140)
Aug  9 17:57:39 boeaet34 kernel: <7urnal_dirturnal_st New handle 1e701240
goingle51069): joansaction.c, 525)_ansaction.de27ec0ll point to 788 will
point toad 1de27dd0, foa<7>ta: journal_headaction.c, 1328): jou going down
Aug  9 17:57:39 boeaet34 kernel: 106e27ec0
Aug  9 17:57:39 boeaet34 kernel: <7aansaction.c, 525): do_ansaction.c,
525): do_gde27ec0
Aug  9 17:57:39 boeaet34 kernel: <7 start_98): start22 credits
(tot>(namei.c, 689): c, 695)525): do_get_write_ac1069): journal_dirgetcopy
0
Aug  9 17:57:39 boeaet34 kernel: <andle 1e83da40 going down
Aug  9 17:57:39 boeaet34 kernel: 1069): journal_dnalget_write_accesfb0,
force_copy 0
Aug  9 17:57:39 boeaet34 kernel: <7ead 1da28fb0, force_copy 0
Aug  9 17:57:39 boeaet34 kernel: 1069): journalnal_hget_write_accesfb0fb0,
na bu_write_access: buffer_head 1de27ec0, force_copy 0
Aug  9 17:57:39 boeaet34 kernel: <wead 1dnal_head 1da28fwl_dirty_metadesean
inode 8c, 1069): journlda40 give>(namei.c, 689)emovk will poead 1de27ec0,
force_nal_head 1de27ec0
Aug  9 17:57:39 boeaet34 kernel: wead 1dnal_head 1da28write_access: buead
1de27ec0, forcel_diess: buffer_head 1da28fb0, force_copy 0
Aug  9 17:57:39 boeaet34 kernel: <ansaction.c, 10etadata: journal_head
ext3_orphan_adblock will point to 816008
Aug  9 17:57:39 boeaet34 kernel: <7da40 going live.
Aug  9 17:57:39 boeaet34 kernel: <write_access: bead 1d1069):
journal_nal_heead ess: buffer_head 1da28fb0, force_copy 0
Aug  9 17:57:39 boeaet34 kernel: <write_access: bead 1da28fb0,nal_head
1da28ffbget_write_accen buffer_head 1de27e60, force_copy 0
Aug  9 17:57:39 boeaet34 kernel: <rty_metadata: jhead 1de27d10
Aug  9 17:57:39 boeaet34 kernel: <7dd: superblock
Aug  9 17:57:39 boeaet34 kernel: <asaction.
Aug  9 17:57:39 boeaet34 kernel: urnal
Aug  9 17:57:39 boeaet34 kernel: <_metadata: jour>(trannsaction.c, 96): sta
1e701240 goinon.c, 198): start_th40)
Aug  9 17:57:39 boeaet34 kernel: <0007>(transaction1240 going down
Aug  9 17:57:39 boeaet34 kernel: an (g dirty.  outer handle=00000000
Aug  9 17:57:39 boeaet34 kernel: <write_access: bead 1de27ec0, force_copy 0
Aug  9 17:57:39 boeaet34 kernel: 1069): journalnal_gec0, force_copy 0
Aug  9 17:57:39 boeaet34 kernel: <71069): journanal_head 1da28ec0
Aug  9 17:57:39 boeaet34 kernel: <>(transle 1e701240 givl 133, enal_head
1da28e90
Aug  9 17:57:39 boeaet34 kernel: <7wead 1da28ec0, force_copy 0
Aug  9 17:57:39 boeaet34 kernel: 1069): journalnal_head 1da28ec0
Aug  9 17:57:39 boeaet34 kernel: ec0, force_copy 0
Aug  9 17:57:39 boeaet34 kernel: write_access: bea_write_access:
buffer_head 1de27ec0, force_copy 0
Aug  9 17:57:39 boeaet34 kernel: >(tranle 1e701240 given 108 credl 133,
fenal_head 1dget_write_accesec01069): journal_dnal_head 1de27ec0,
forcel_diaess: buffetadata: journeblock an inode 84864c, 1069): jour,
1328): journal_stop: Hand1240 given 2>(namei.c, 689emove inode 848645 from
ok wilead 1d1069): journalnalget_write_accesec0, foread 1da28ec0,
force_cnal_head 1da28ec0
Aug  9 17:57:39 boeaet34 kernel: get_write_acceec0, gec0nal _write_access:
buffer_head 1de27ec0, force_copy 0
Aug  9 17:57:39 boeaet34 kernel: write_access: buffer_head 1de27bc0,
forc1069): journal_nal_hget_write_accesbc0get_write_accesbc0, force_copy
na: do_get_write buffer_head 1de2_write_access: buffer_head 1de27ec0,
force_copy 0
Aug  9 17:57:39 boeaet34 kernel: <7c0, fext3_orphan_add willc0, foal_head
1(transinode 881291 from 695): ext3_orph<7>(transaction.c, 1069):
journal_dirty_metadatot_write_access: buffer_head 1de27bc0, force_copy 0
Aug  9 17:57:39 boeaet34 kernel: <dirty_metadata: journal_dirty_me
Aug  9 17:57:39 boeaet34 kernel: ited, 663): ext3_orphan_add: superblock
will point to 881304
Aug  9 17:57:39 boeaet34 kernel: <7e_copy <7>(t>(transaction.c, 198):
stare83db80 given ts (total 59, from orphan list
Aug  9 17:57:39 boeaet34 kernel: <_write_access: head 27b00,
force_crnal_head 1de27saction.c, 106hi.c, 663): et3_orphan_addt_wri5): do
force_copy 0
Aug  9 17:57:39 boeaet34 kernel: <69)7b00
Aug  9 17:57:39 boeaet34 kernel: <7897619
Aug  9 17:57:39 boeaet34 kernel: t_write_access: buffer_head 1de27ec0,
force_copy 0
Aug  9 17:57:39 boeaet34 kernel: <<handle 1e83da8nsac83da80 given 108
credits (t, free ata: journal_, force_copy 0
Aug  9 17:57:39 boeaet34 kernel: <5): do_ 663): ext3_or12193
Aug  9 17:57:39 boeaet34 kernel: e_access: buffce_copy
1de27ecce_cope_access: buffce_cop 1da28e00
Aug  9 17:57:39 boeaet34 kernel: sactiead 1de27ec0,
sactisacttransaction.c,transaction.c, 1328): jour01240 going dow 96):
start_this_hanoing live.
Aug  9 17:57:39 boeaet34 kernel: >(transacti069): journet_write_access:
bufet_wornal_d069): journal_0
Aug  9 17:57:40 boeaet34 kernel: 7>(transactiournal_stop: New hon.c, 198):
stle 1e701240 given 1 7140)
Aug  9 17:57:40 boeaet34 kernel: <ead 7>(transactionl.
Aug  9 17:57:40 boeaet34 kernel: <79): journal_dirty_m): do_force_copy 0
Aug  9 17:57:40 boeaet34 kernel: <79): journal_dirty_mbadd: super665):
ext3_orphan_add: orphan inode 962895 will point
to(transaction.ct_write_access: bufferadata: journal_h>(transaion.c, 198):
start_thie 1): do_get_write 1de27980, force_copy
1o_get_write_acffccnal_dirty_metadata: joutransaction.c, _metadata:
journaon.c, 1069): j: journad 1da28b90, fortransaction.c, 13 1
Aug  9 17:57:40 boeaet34 kernel: <7action.c, 525): do_get_write_access:
buffer_head 1da28b90, force_copy 0
Aug  9 17:57:40 boeaet34 kernel: e27e60, force_copy 0
Aug  9 17:57:40 boeaet34 kernel: <rnal_dirty_metournadirty_metadataopy 0
Aug  9 17:57:40 boeaet34 kernel: duffer_head 1de27e60, force_copy 0
Aug  9 17:57:40 boeaet34 kernel: >(t: journal_head 1da286b0
Aug  9 17:57:40 boeaet34 kernel: <(transaction.c, 1069):
journal_dirty_metadata: journal_head 1da286b0
Aug  9 17:57:40 boeaet34 kernel: <7dd: orphan inode 1256641 will point to 0
Aug  9 17:57:40 boeaet34 kernel: <r_head 1d9a5a10, force_copy 0
Aug  9 17:57:40 boeaet34 kernel: 5): da7>a: journal_head 1d9a5a10
Aug  9 17:57:40 boeaet34 kernel: <ction.c, 525): do_getd 1d9a5a10,
forction.7>(transaction.c, 1069): ction.cd 1d9a58c0, forction.cforce_copy 0
Aug  9 17:57:40 boeaet34 kernel:  1069):le  going live.
Aug  9 17:57:40 boeaet34 kernel: <: ext3_forget: forgetting bh 00000000:
is_metadata = 0, mode 100644, data mode 800
Aug  9 17:57:40 boeaet34 kernel: <7): jo7140)
Aug  9 17:57:40 boeaet34 kernel: <7d.
Aug  9 17:57:40 boeaet34 kernel: <7tada5ion.cion.c, 1069): jour ion.c,
1069): jornal_dirty_met_write_access: buffer_head 1d946770, f): do_get_writ
1d946770, force_copy 0
Aug  9 17:57:40 boeaet34 kernel: namei.c, 689): ext3_orphan_del: remove
inode 1795201 from orphan , 695): ext3_orphan_d0
Aug  9 17:57:40 boeaet34 kernel: <e1da28920, force_copy 0
Aug  9 17:57:40 boeaet34 kernel: <7 Handle 1e83da8totaoetadata = 0, mode
40755, data modee: insert revoke for block 58865152, bh_in=00000000
Aug  9 17:57:40 boeaet34 kernel: <7e60
Aug  9 17:57:40 boeaet34 kernel: < handle=000000020, force_copyet20,
for_dirty_metadataal_h3da80 going down
Aug  9 17:57:40 boeaet34 kernel: <nsaction.c, 525): do_get_write_access:
buffer_head 1d946320, force_copy 0
Aug  9 17:57:40 boeaet34 kernel: <a28920, force_copy 0
Aug  9 17:57:40 boeaet34 kernel: e 1e83da40 goi
Aug  9 17:57:40 boeaet34 kernel: 69): journal_dirty_t_wrt_write_access:
buffer_
Aug  9 17:57:40 boeaet34 kernel: this_handle: Handle 1e8transaction.c,
forcl_dirty_metad7 buffer_head 1de force_copy 0
Aug  9 17:57:40 boeaet34 kernel: write_access: b l_dirty_metad7f80
Aug  9 17:57:40 boeaet34 kernel: <l_dirty_metada8e0block will poii.c, 665):
ext3_orphan_add: orphan inode 212210 will point t, 525):
do_get_write_access: force_copy 0
Aug  9 17:57:40 boeaet34 kernel: <
Aug  9 17:57:40 boeaet34 kernel: <7 h_ref 2 -> 1
Aug  9 17:57:40 boeaet34 kernel: <727ec0
Aug  9 17:57:40 boeaet34 kernel: ef 2 -> 1
Aug  9 17:57:40 boeaet34 kernel: <en 108 cite_access: buffer_head 1d8e7bf0,
force_copy 0
Aug  9 17:57:40 boeaet34 kernel: )ata: journal_head 1d8e7c1328): journal_0
going down
Aug  9 17:57:40 boeaet34 kernel:  30 credits (to, 61): ext3_for0000000e 800
Aug  9 17:57:40 boeaet34 kernel: ransacn.c, 525):e_copy 0
Aug  9 17:57:40 boeaet34 kernel: cess: buffer_head 1d8c2ef0, force_copy 0
Aug  9 17:57:40 boeaet34 kernel: 25, force_copy 025):
do_get_write_acrce_copy 0
Aug  9 17:57:40 boeaet34 kernel: <7rcess: buffer_head 1d8e7c50,
force_copymetadata: journal_head 1d8e7c50
Aug  9 17:57:40 boeaet34 kernel: <7i0
Aug  9 17:57:40 boeaet34 kernel: <7te_access: buffrce_coe.c, 1069):
jourjournad8e7950,er_head 1de27e60, force_coer.c, 1069): jourjournal_head
1de27e60
Aug  9 17:57:40 boeaet34 kernel: urnal_dirty_metajournal_head 1de27ec0
Aug  9 17:57:40 boeaet34 kernel: ei.c, 663): ext3_orhget_write_acces25):
do_get_wrad 1d8e7c50, force_copy 0
Aug  9 17:57:40 boeaet34 kernel: <ta: journal_head 1d8e7c go_handle: New
handle 1e83d840 going live.
Aug  9 17:57:40 boeaet34 kernel: _access: buffer_e_copess: buffer_heac50,
force_copy 0
Aug  9 17:57:40 boeaet34 kernel: <copy 0
Aug  9 17:57:40 boeaet34 kernel: <g down
Aug  9 17:57:40 boeaet34 kernel: ccess: buffer_copy 0
Aug  9 17:57:40 boeaet34 kernel: <ee27ec0
Aug  9 17:57:40 boeaet34 kernel: n_del: remove inode 2023681t to 0
Aug  9 17:57:40 boeaet34 kernel: <ccess: buffer_hcopy copy 0to ess:
buffer_head 1da28e00,py 0
Aug  9 17:57:40 boeaet34 kernel: < 800
Aug  9 17:57:40 boeaet34 kernel: <py 0
Aug  9 17:57:40 boeaet34 kernel: <del: remove iny 0
Aug  9 17:57:40 boeaet34 kernel: <7d 1dte_access: buffer_head 1d8e7650,
force_copy 0
Aug  9 17:57:40 boeaet34 kernel: <7saction.c, 525ead 1d8c2d40, fsac, 525):
dosactional_head 1d8c2: ext3_n_add: orphan inode_ 0
Aug  9 17:57:40 boeaet34 kernel: <t3_forget: forgetting bcopy 1
Aug  9 17:57:40 boeaet34 kernel: <saction.c,sactional_head 1d8c2d, 525):
saction.c, 5ead 1d8c2d40, fosact, 525): dsaction.c, 1069): jonal_head
1d8c2: extn_add: orphan inode 22>(transaction.c_access: bufferansaction.c,
52ge1396): start_this_handle: New handle 1e83d8c0 going live.
Aug  9 17:57:40 boeaet34 kernel: 8c>(transacti: journal_head 1de27ec0
Aug  9 17:57:40 boeaet34 kernel: <saction.c,, sactioead 1d8c2d40,
force_copy 0sact, 525): dsactionnal_head 1d8c2d: ext3_orphan_add: n_add:
ansaction.c, 5ge1328): journal_stop: Ha96): start_this_handle: New handle
1e83d8c0 going live.
Aug  9 17:57:40 boeaet34 kernel: <urnal_head 1d8c2f50
Aug  9 17:57:40 boeaet34 kernel: d 1d8e7650
Aug  9 17:57:40 boeaet34 kernel: <snal_head 1d8c2d, 525):
do_get_write_access: buffer_head 1d8c2d40, force_copy 0
Aug  9 17:57:40 boeaet34 kernel: s: buffer_head 0
Aug  9 17:57:40 boeaet34 kernel: n.c,l_dirty_metadata: jamei orc2cb0,
force_copy 0
Aug  9 17:57:40 boeaet34 kernel: <n.cl_dead 1d8c2f50
Aug  9 17:57:40 boeaet34 kernel: nsaction.c, 96): start_this_handle: New
handle 1e701180 going live.
Aug  9 17:57:41 boeaet34 kernel: sa
Aug  9 17:57:41 boeaet34 kernel: <7ead 1da28bc0, force_copy 1
Aug  9 17:57:41 boeaet34 kernel: Assertion failure in journal_forget() at
transaction.c:1184: "!jh->b_committed_data"
Aug  9 17:57:41 boeaet34 kernel: kernel BUG at transaction.c:1184!
Aug  9 17:57:41 boeaet34 kernel: illegal operation: 0001
Aug  9 17:57:41 boeaet34 kernel: CPU:    0
Aug  9 17:57:41 boeaet34 kernel: Process rm (pid: 534, stackpage=1DA59000)
Aug  9 17:57:41 boeaet34 kernel:
Aug  9 17:57:41 boeaet34 kernel: Kernel PSW:    070c0000 8008023c
Aug  9 17:57:41 boeaet34 kernel: task: 1da58000 ksp: 1da599b0 pt_regs:
1da59918
Aug  9 17:57:41 boeaet34 kernel: Kernel GPRS:
Aug  9 17:57:41 boeaet34 kernel: 00000000  8001c118  00000022  00000001
Aug  9 17:57:41 boeaet34 kernel: 8008023a  00c2b000  00197198  00000001
Aug  9 17:57:41 boeaet34 kernel: 1d9ed780  1def2294  00001899  1da28710
Aug  9 17:57:41 boeaet34 kernel: 0001f94c  800800ac  8008023a  1da599b0
Aug  9 17:57:41 boeaet34 kernel: Kernel ACRS:
Aug  9 17:57:41 boeaet34 kernel: 00000000  00000000  00000000  00000000
Aug  9 17:57:41 boeaet34 kernel: 00000001  00000000  00000000  00000000
Aug  9 17:57:41 boeaet34 kernel: 00000000  00000000  00000000  00000000
Aug  9 17:57:41 boeaet34 kernel: 00000000  00000000  00000000  00000000
Aug  9 17:57:41 boeaet34 kernel: Kernel BackChain  CallChain
Aug  9 17:57:41 boeaet34 kernel:        1da599b0   [journal_forget+406/736]
Aug  9 17:57:41 boeaet34 kernel:        1da599b0   [<0008023a>]
Aug  9 17:57:41 boeaet34 kernel:        1da59a18   [ext3_forget+250/356]
Aug  9 17:57:41 boeaet34 kernel:        1da59a18   [<000747e6>]
Aug  9 17:57:41 boeaet34 kernel:        1da59a80
[ext3_clear_blocks+204/260]
Aug  9 17:57:41 boeaet34 kernel:        1da59a80   [<00076c00>]
Aug  9 17:57:41 boeaet34 kernel:        1da59ae8   [ext3_free_data+232/260]
Aug  9 17:57:41 boeaet34 kernel:        1da59ae8   [<00076d20>]
Aug  9 17:57:41 boeaet34 kernel:        1da59b60
[ext3_free_branches+424/436]
Aug  9 17:57:41 boeaet34 kernel:        1da59b60   [<00076ee4>]
Aug  9 17:57:41 boeaet34 kernel:        1da59bd8
[ext3_free_branches+264/436]
Aug  9 17:57:41 boeaet34 kernel:        1da59bd8   [<00076e44>]
Aug  9 17:57:41 boeaet34 kernel:        1da59c50   [ext3_truncate+782/1040]
Aug  9 17:57:41 boeaet34 kernel:        1da59c50   [<000771fe>]
Aug  9 17:57:41 boeaet34 kernel:        1da59d08
[ext3_delete_inode+242/356]
Aug  9 17:57:41 boeaet34 kernel: >       1da59d08   [<00074aa2>]


--
Mit freundlichen Grüßen / Best Regards

Christian Bornträger
IBM Deutschland Entwicklung GmbH
eServer SW  System Evaluation + Test
email: CBORNTRA@de.ibm.com
Tel +49 7031-16-3507


