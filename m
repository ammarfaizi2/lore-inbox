Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUBXISi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 03:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUBXISi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 03:18:38 -0500
Received: from hendrix.ece.utexas.edu ([128.83.59.42]:39081 "EHLO
	hendrix.ece.utexas.edu") by vger.kernel.org with ESMTP
	id S261605AbUBXISe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 03:18:34 -0500
Date: Tue, 24 Feb 2004 02:18:31 -0600 (CST)
From: "Hmamouche, Youssef" <youssef@ece.utexas.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.6.3 - Debug: sleeping function called from invalid context
Message-ID: <Pine.LNX.4.21.0402240204510.5314-100000@linux08.ece.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm having some issues with ibm t22 laptop. I've been having these traces quite
frequently in my logs:

Feb 23 23:22:46 darkstar kernel: Debug: sleeping function called from invalid
context at include/asm/uaccess.h:473
Feb 23 23:22:46 darkstar kernel: in_atomic():1, irqs_disabled():0
Feb 23 23:22:46 darkstar kernel: Call Trace:
Feb 23 23:22:46 darkstar kernel:  [<c012235b>] __might_sleep+0xab/0xd0
Feb 23 23:22:46 darkstar kernel:  [<c011b157>] do_read+0xd7/0x200
Feb 23 23:22:46 darkstar kernel:  [<c0175f3f>] vfs_read+0xaf/0x120
Feb 23 23:22:46 darkstar kernel:  [<c01761cf>] sys_read+0x3f/0x60
Feb 23 23:22:46 darkstar kernel:  [<c010a48b>] syscall_call+0x7/0xb
Feb 23 23:22:46 darkstar kernel:
Feb 23 23:22:46 darkstar kernel: bad: scheduling while atomic!
Feb 23 23:22:46 darkstar kernel: Call Trace:
Feb 23 23:22:46 darkstar kernel:  [<c011fb55>] schedule+0x8e5/0x8f0
Feb 23 23:22:46 darkstar kernel:  [<c011dfd8>] kernel_map_pages+0x28/0x70
Feb 23 23:22:46 darkstar kernel:  [<c015005f>] __alloc_pages+0x35f/0x3d0
Feb 23 23:22:46 darkstar kernel:  [<c011cb0d>] do_page_fault+0x11d/0x588
Feb 23 23:22:46 darkstar kernel:  [<c013231d>] schedule_timeout+0xdd/0xe0
Feb 23 23:22:46 darkstar kernel:  [<c01500f2>] __get_free_pages+0x22/0x50
Feb 23 23:22:46 darkstar kernel:  [<c0191768>] __pollwait+0x38/0xb0
Feb 23 23:22:46 darkstar kernel:  [<c011b2d0>] do_poll+0x50/0x70
Feb 23 23:22:46 darkstar kernel:  [<c0191b17>] do_select+0x247/0x400
Feb 23 23:22:46 darkstar kernel:  [<c0191730>] __pollwait+0x0/0xb0
Feb 23 23:22:46 darkstar kernel:  [<c0191ff6>] sys_select+0x2e6/0x530
Feb 23 23:22:46 darkstar kernel:  [<c0163f8f>] unmap_vma_list+0x1f/0x30
Feb 23 23:22:46 darkstar kernel:  [<c010a48b>] syscall_call+0x7/0xb
Feb 23 23:22:46 darkstar kernel:
Feb 23 23:22:47 darkstar kernel: bad: scheduling while atomic!
Feb 23 23:22:47 darkstar kernel: Call Trace:
Feb 23 23:22:47 darkstar kernel:  [<c011fb55>] schedule+0x8e5/0x8f0
Feb 23 23:22:47 darkstar kernel:  [<c010c805>] do_IRQ+0x255/0x3b0
Feb 23 23:22:47 darkstar kernel:  [<c010a4b2>] work_resched+0x5/0x16
Feb 23 23:22:47 darkstar kernel:


Should I just rebuild without CONFIG_DEBUG_SPINLOCK_SLEEP and hope all goes
well? Recently, the system crashed and had to alt-sysrq-b to get away. here's
what the logs picked up:

Feb 23 23:22:47 darkstar kernel: Debug: sleeping function called from invalid
context at include/asm/uaccess.h:473
Feb 23 23:22:47 darkstar kernel: in_atomic():1, irqs_disabled():0
Feb 23 23:22:47 darkstar kernel: Call Trace:
Feb 23 23:22:47 darkstar kernel:  [<c012235b>] __might_sleep+0xab/0xd0
Feb 23 23:22:47 darkstar kernel:  [<c011b157>] do_read+0xd7/0x200
Feb 23 23:22:47 darkstar kernel:  [<c010a5f8>] common_interrupt+0x18/0x20
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
^@^@^@^@^@^@^@^@^@^@^@^@^@^@��^N�C�H^\^^@.8�k�.��.#��G.�����^Z�^L.�..jqQ.�O5��.L^C.4�a.{��^O+^[^[^F�^Qƻ\^Xv�L.^N�bnD0^Qo^Ti.y�ʪX���T�^U�...�Ix��.�^F�n���𪭧.�.p0�^
K�
e��w[^M4w�h�7c�ڼ�^F���^�.C....;14�^\�m�B.XX�2^G{�^Y`^^Iǩ�.��,^L.]^D!..b)^LcFR.X
^G�=����37Vt0<�'9K�^S�$..�1��^G�&4�u2^Er���Žn�.�2")�ա.�.��z.�^^�^S�..�p8T!^E�প�.^M��Z�
dsû�|h��^E�.�Z.lT{Q(.�k^E.h�.�.^O^E
.f�.�"Yd%u7.~��.$Ⱦ.�^H^\"x��L1;���1�.p$3ӳ.�BNӯI..D��.&Z�^H.�1C���N}^N�.{^C�.^B^Q;u^@�O8.�6.X�.^T^K^W^M
[11:_��mNzxt^Y�;+..;^E_��_�õ�D.�^H^\B!�;z9^Au.^Pa^Ae�6^H�����RJ�..lmLSf.����:��|u|..9t�}^?^XRY(�����z�֠t�.u�^U�sK.+^MT@C�.L.^�Hw�:^S��^L�9^C.p_m�.3p��ȾIѩ.^L�a.�c�
��9�~i�r�M��9S.^H^\v��x^\δ�g�..�!^_.-"^H^_�.^XI�z���^G�^?�. �~^O..�2m��.$n^S��8DR1.]^O=m*�.w�^@^L<;j^O^[apC�-%�...W}�Y
�u^A�.B
{:�t0�/�A..úA�?^^�|.0�^H^L.��O�^\^Xl.8a?�|R���.?^],�R°��d���.(ʭf.�^^�D�_��6^T^Q�^Q@D�
���w�^^^\�^]ںB^Sѻ�...`�Y09�|�^T��.�D\�s�^W0$y�.�}Z��O.��@�r�vp�z^P�^^i��N
/@��.�.�V�^Zg�q..r^LQ^A.�`A:.+.�pZ.���A^N^An,{>^_.���^Z�;�.�^_^Q���(^V.��c^B*�xk.�`=������A.D^Z^G#�����_^L��^U}.^X.�>^N=..&.��!�"�|��u^Oo����RA�^A.�^Eyǭ�^T��.\)��TA
^O^Z���^F^G.���.L.�J��^O�뻮=��........�?.s�j�T�S).�k.�.���h^@^D.^A#^L^QUQ^X^H.��^N�.3^L\3^L�y��^Szl|^W^A@
�{� �^Q^D^X�'�W..e�^S�`^@^@^@^@^G^�y�W*H^^.�`^B"."'��..��Q�
y��.�Kq�^MJ7.^Y-^Z.nZ�.W
fdphܦ^Ne�̸8�n&^N%^[.0�0ʴ�)o����k0g^P�m�.ܵ]UUI.
*��..�{^P�..�^A_+�u+��nUS��^T�y��y<��^@^@���^A^Q�p��g׫�ۭH^G�."B"�
�0X�z�y�.P�x衮�D^P G.�Bsr.^@^OR.��m.,).Ӫ^T.`�('k�WO^wT�#�t�4F^DU.4qa^O.��}.
>^].^C�.��     �߬�HC��:ӵ�@�.&.�%N��2^L
�.L.F!�\.     ^A.^BL%��^ENpS^@�^Q9a^L(h^Q;p�h�5Ơ.�z'�^A~�-.^F
>��0^O�E1��OlG^X��[^Ni�P^@���^S��^F.����.�$..�.^C]B.��..�L���
^BM.0..^U�.^^�^]��.��C^_,��.�^L^Uo^Xv��.<��g.^R.�^H"�O.F^Z5`�^C0o.<j��^[[^ML�Q�ˬ���.�KW^_=ն�..o���V���4^MeA^NTk��^P<^B#ݩ^F^_.>��.u^S��1�R�^AO%^Q..^M�!.�b�l[^C.�6.
2^U.y�{�.Mj1^U�1G4��^P^F^^.�l^V
<ZA^Gn�{ڼ^B@L�^T���D.*^Q�xZ^R�n��.rD$DC��.^Y*^T�^C�
M.�����.|�s���.        ^P9:>�,>.�"�D..5��.�߷^Q=k�w�N�M^Ec\��x.cT�^U^PP^@.�.^S[�8.,^@i��W�..�^Z.���^^.<|!�v��/^N�HI^E�J^Px^]��=�.T�bK��J4^C�&+`.       d��^Q'.��.D.�.
�!��..'[du�:�1r�S_.���""%^^?^]_^M��|[`l)�.�9�.{w{�4���{S��,�.^GǱ�>!RT^HA..t�/8�;**^].P^U:�lu^\0";u�t..�^[
�^O_�w�[r��ACS^P�C饴9Q2�K��.R�\�2..w����}$}^HA|�.��.^^^
V�^N.��QN�^T.9��^LD��C.$!^T^W^\�z34^N�^MY�O
n�zl.�..^Ou9�U{kݩ.��GK^]K�6-^O�|ap@��P
�g����>��~r�W^S#.Z^V��_.".z���^B1�2-^A�X6�.;<�:^G�^H�?��^_�^D�^_^R�x^R.bz���).3{S�^\���ݰj��8��^G�G^��..�,��*'�L�&N�����
.���^B.|E.K^Y�^Y��d='KQR�].`�k9������u�G�.��.^UQi�^]��*m^]..x^V%�[TV*.^Z�k}~�^?.���^RRHa�`�=�S*�K^R.���G�5w�.�.^X.^_.�.)�.. �.�.�#9�&J�.Z..�dY�.H��n�^A�.N^Z^GhZ^Z�^R�
9�.r$8�j��9^\�\=���S�.s��^Q�O^U���.�..Z.^MJ�'<^��^F.M�.S.�l^@u(m^D
^Fj%�U.u40.}.9^EKU�2%3q^T֭d'-�|.�R�;p..�j.�J.��..@R.^X's&�^]�I���N.7�$�..�^G�D?���^?r.I���^V
�^_J�.�^RU.^R^@��.^T A0P%.^P�='~z[�.�}*���^fsr.�^%^Fm�V_�Yq��.*.��(^P߾
CMo#+>?{.^�����R  t.�xq^_`�H.�^K��R���^Zy����k..��
�~M.^LA."�.\^F.<.>..ga�PF�Ok��_�b^^B�^H���^].#6^]��~TI..K�^U�.;.^^^DlP�%�^F?<���oF�JK^Vxݸy�D*�z|�����.^P.���׵4g<Ӭ.s.�P'�6g�.��&˥�^H2.^B.�?����^?t^_.^D\(^G^@^P�t9
^K7+mO�.�^FY��ٴ.�V��5ӣ�W���ޫ.$����*�N�3.OID��3.^G�㡿.�X^A^Nɵ�S
^Y.��tN^]�P^M..��B��.#^H^P��.�^B^QW�^@.N���.:^_�6.�^R�^M�K�.^O.��^V��.�C�^Gq..^>�.�.H.p��.
�7.^C:P^P��^D��.U]�..       R).v�.��.^Y
R�[b�co^^�.��o�"^H���.�7�^Xa^Neq.. ..[^U�^P.�^P><�1K!�^�.       �^M�7<|.<��{3����<�95.^?�^O4^G�..H���H,"�4�%X�^Y^O�BX.F{���C�:�^S[�4^�L�ভSg���8�^NvO�X.�.M2{^Pi�����
�m�7�.'^E%.K,.�.\�>..ŽV^_.s}    ��.w�i�,.�9X.�M��m�
1:�M��*��.��.�s.Lص�^P)^Q�$�~p�s.|^Ca�M.e^C)^P^PBR^E�,3��[r]�.^\6.C}R.^P..�<^^^G^QP^].sy.m3�.fd.�.S�^C.�g.N�
�.^EzսS)��(.p�>�.^.^P3��c^M{^�Yy�^MVb�c.�^S&�^P�.�^^V�^Q��p��.D�.qNG`��1T>�>���..Q�,P�79
�&�.^\.�.�^���]��si.H.%�*7-e^T�=w,f�.��Ͷ�9^S�S^L.��S
[`^V�r:�����.npN       8�A�7.'^E�%K^]�^Z|<��bB�b3�c���^M.�C�W1�x�^PE�9
X�xf�h^P:�^NY.�r.^X^^�0(.�^N
^^vM(8|v^P6S��.�.w�*˸.J��P�^G?Y�^Q^?..q4.P.��.=q.1D=�h^E.���)"^G



this is 2.6.3 + apm. I've noticed the system takes slightly longer than usual to
get back from sleep and turn on the diplay (only after hard drive 
activity). Also, the traces don't show up until it gets back from sleep.

sorry about the above garbage.

thanks,

-you

