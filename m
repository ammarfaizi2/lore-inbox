Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbUA3KeU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 05:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUA3KeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 05:34:20 -0500
Received: from debian.as ([217.73.97.14]:48869 "EHLO solitude.debian.as")
	by vger.kernel.org with ESMTP id S262033AbUA3KeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 05:34:13 -0500
Date: Fri, 30 Jan 2004 11:34:09 +0100
From: Tobias Bengtsson <tobbe@tobbe.nu>
To: linux-kernel@vger.kernel.org
Subject: BUG? Bad page state at free_hot_cold_page
Message-ID: <20040130103409.GA20848@debian.as>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
X-PGP-Key: http://tobbe.nu/pgp
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, I've had this problem since at least 2.6.1.

This output I got from a 2.6.2-rc2 compiled with the config attached 

I looked in include/linux/page-flags.h and found out that flags:0x20000094
probably mean

100000000000000000000010010100
                      |  | |_PG_referenced
                      |  |___PG_dirty
                      |______PG_slab

which actually don't tell me anything, but you'll probably do better.

this kind of error crash my machine (see below) almost daily.

cheers, Tobias

PS. Please cc me the replies to this thread as I'm not subscribed.

----8<----8<----
Bad page state at free_hot_cold_page
flags:0x20000094 mapping:00000000 mapped:0 count:0
Backtrace:
Call Trace:
 [bad_page+69/112] bad_page+0x45/0x70
 [free_hot_cold_page+61/256] free_hot_cold_page+0x3d/0x100
 [page_remove_rmap+356/368] page_remove_rmap+0x164/0x170
 [free_page_and_swap_cache+57/112] free_page_and_swap_cache+0x39/0x70
 [zap_pte_range+342/432] zap_pte_range+0x156/0x1b0
 [path_release+17/48] path_release+0x11/0x30
 [link_path_walk+164/2560] link_path_walk+0xa4/0xa00
 [zap_pmd_range+69/96] zap_pmd_range+0x45/0x60
 [unmap_page_range+47/96] unmap_page_range+0x2f/0x60
 [unmap_vmas+243/512] unmap_vmas+0xf3/0x200
 [exit_mmap+105/384] exit_mmap+0x69/0x180
 [mmput+92/128] mmput+0x5c/0x80
 [do_exit+334/1024] do_exit+0x14e/0x400
 [timer_interrupt+79/320] timer_interrupt+0x4f/0x140
 [rcu_check_quiescent_state+87/128] rcu_check_quiescent_state+0x57/0x80
 [rcu_process_callbacks+70/288] rcu_process_callbacks+0x46/0x120
 [tasklet_action+85/112] tasklet_action+0x55/0x70
 [do_softirq+91/160] do_softirq+0x5b/0xa0
 [do_group_exit+117/176] do_group_exit+0x75/0xb0
 [syscall_call+7/11] syscall_call+0x7/0xb

Trying to fix it up, but a reboot is needed
----8<----8<----
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 10
model name	: AMD Athlon(TM) XP 2600+
stepping	: 0
cpu MHz		: 1916.547
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 3776.51

-- 
http://tobbe.nu/.sig

--YiEDa0DAkWCtVeE4
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

H4sIAOHsGEACA4xcWXPbuLJ+P7+CVfNwk6rMRItNy6cqDxAISjgiCJgAteSFpbEZR3dsyUeW
Z+J/fxukFoAE6PsQx+yv0dgavWDxb//6LUBvh93z+rC5Xz89vQeP5bbcrw/lQ/C8/qsM7nfb
H5vHfwcPu+3/HILyYXP412//wjyN6aRYjsJv76cPxvLLR06jvoFNSEoyigsqURExBAAI+S3A
u4cSajm87TeH9+Cp/Lt8CnYvh81u+3qphCwFlGUkVSi5SMQJQWmBORM0IReyVCiNUMJTgzbO
+IykBU8LycSp6knVy6fgtTy8vVwqkwskDGkrOacCAwHaehQmo0JkHBMpC4SxCjavwXZ30HKM
UlgZTU04FMvjQk5prL71r050Oqt/uXCeKFUNZq2EjUkUkchR2wwliVwxeZES54osL59E8MRo
DeUST0lUpJyLNhXJNi0iKEpoNaLnBmFccKEoo99JEfOskPCL2bhqjJPd+mH95xNM8e7hDf57
fXt52e0N/WE8yhNiVFkTijxNOIrM+o4AVIVPsGMs+FjyhCii2QXKWEPCnGSS8lS6RhHgk2qI
/e6+fH3d7YPD+0sZrLcPwY9SK2n5aql+YWuGpsz5Ck1IZlZg4WnO0J0XlTljVHnhMZ2AAnvh
OZUL6UWPKxBleOrlIfKm1+s5YTYchW7gygdcdwBKYi/G2NKNhT6BAmwDzRmlH8Dd+JUbnYUO
dWGzG0u3ZiN3YZKg1I3gLJecuLEFTfEU7E7YCQ860WHkqXeV0aV3KOYU4WEx+EiLHCOiUczE
Ek8Ne6aJSxRFNiXpFxiBZTkaxPCEZQtJWKElQJECJROeUTVlduGFKBY8m8mCz2yApvNENOoe
2+a8WrNcoKhVeMI51CgobspUJClySTLMxcrGgFoIsNMF9ATPYOm24WGU8sWFPBVEFWAzSdag
EZYnCKxWpiyD0ljsZ9dACBOqUZtwtB6IlLfJCccocXWWO4iwUG0Cw6RFAF+SxshyzydEXKkp
yVgFnTumOMz8GDm1jI5mbtWkGHwij4hXN5nMfHopIBwxHKKpkCmf0smUEctXHElXE2dlRzT0
wAyp6XFKwdm4jIfKMsu5x9TBNUVzAq4X6/manV3T7p9yDxHTdv1YPpfbwylaCj4hLOiXAAn2
+eKjhNUpyWO1QBksu1yCyXPbB8GKiMpZy5Vr8VDJw9/r7T1EhrgKCt8gTITaKw9Zt4xuD+X+
x/q+/BzIprPXIi7jrr+KMeeqQdJLLgMdV+YqqRCZECJctCpaKmLZwJC1mOr6kAK5K8do13Cu
FE8bYmLUpBzDP95soEPT64bAgDsHuy7VsRgqhoiM84m/yc1uE9xsLl+0xlLg5lRA0KrsRVCR
M/BgSx0XsqStE4IZKlErADur5udgDAGkoQYXwVCuKQuWaBDvy/++ldv79+AVMpHN9tEsBAxF
nJG7Vsnx2+tlFUC/vgQCM0zRl4BAtvElYBh+wG/muqh6f9F5TMEBVK11LokKjmhGnNF+DaPU
cA+apMXZlFpCs2LtJ+ZA55lHdkImCK9OGYEBpIhVofPFdErk8fluusS/Bna4dzI9XIkkn5yN
TjWeX/F6/6AH+7U9ozVHa2qglcF0d3h5ent06cGxGt2ZVlHyq7x/O1TJw4+N/rHbQ55oxN9j
msYMXGcSG4leTUM8V9+eG0RGK09WCY/Kvzf3ZRDtN3+Xey3zkhFu7o/kgJ/z0HOD40WhEw87
vq8YWPm8278Hqrz/ud097R7fj3WASjIVfTaFwHd7oNaQij5B8quHqJ0mQSojeGZYyiOhTkBa
NIjDkr6lZ0cI4hiKEreSX0rHNOYf8chc5+TdbFzbw06O/mB01R4LrS2VR3lavxtjUS/2p939
X8FDPbaGMiQzMJPzIo4a3aaeeEEXwOKuiFAnjClk+R08us4I4duw18mSQ7TgWGYnOLEy8RMV
ZyuheIU9N7F0HLWJGWJOYpWbf7vq3YZNkKZUZdaQJeO2ckJg9xX+CfqVxexrliRtBYVhbneg
Jh7ntFy/Qv5fwqLb3b9p91BFDl83D+Ufh18HvbyDn+XTy9fN9scugJBCT9yDXojWAjyJnkZF
Y2bbdeswxtjLqAkFhGWK6r0AazfjhEqlt4q65WJrwAwAhoh0qgHwxAkXYvURl8TSnZ8BVigE
DaUcq8TRzhNDTBMCTKfx14N1/3PzApynyfv659vjj80v9/hiFoVXve5xsEKI+hsSOh1f0uzO
NUQ8jsccZVGH2GN66SwtFA0H/c6hy773e70Pmh0x1PT/DbTaY4rcg3ssXaBc8aYCAcTTZNUM
n5s8uviCio5WonqHtNU+RHA4WC47hwAltH+9HHbzsOjm6gM5lQZ0s6iMxgn5QMxqNMDhbXd7
sLy+HvQ+ZBl2s0yFGn7QYs0Shp0sEvcHve6KBKXd1aRydHPVv+4WEuFBDyaz4EnXgjizpcTY
SDhTK1V1qYqcL2ayu6OUMjQhH/DAsPe7J08m+LZHPhhVlbHBbdfCnFMEirJcLtserF42jsVG
52P/Im0uUE1LedoINR2OpeX+KmNcRxxtx6dBK8eG71M66pZ0FFFvLX962Lz+9SU4rF/KLwGO
fs84++yyx9KdrONpVsOqE+bSw3AWn3WLn7S7snsuzZGBOLf84/EP6EPwv29/lX/ufn0+9/T5
7emweYEYPslTy9tUg1U7ZIA8KYrUOWgVLQKP9DPB7/rsR3WwJHwyoenEPS9Pu39+rw+gHs5p
QWughosCdHQJURWN/PUg3PByDRjhD8pTfLP02GeToWk72ky3nVKiOUoh7fdzMEg9u5sqITD0
o+NcwphT3DFr4i7GXXMWseWwf9vvaALpbIJGwWJzP0ecqxyClogzRDuUcBKpqR+loqMPEGaj
vsep1AZDdPSAMtYx/it2PcQj0IWBn+mumoSCSvEhT4w/ZIGkzWXJjyxooBXzfK7ZlIAG/S6V
1AyDjxiGXQwRHt5e/+rGe8qPp1IMO4aytRdXZ//awv1u+4jgU7VydCKbzM1NWRa1UyWTxqJC
H7aizCJpYb0Wpd+iXLco4cWlAqUytwKpabsRkXGCEbE6xSjmV6ccIn571Xu9TKi2N6yTDEJI
0B/eXgWf4s2+XMC/ixP4ZJ7iWz5OF6tKNUeVDni7pkuxAW+VSMvDP7v9X5vtY9tTp0SdemKw
tS4bCIRnxNpp0d8FY+Y5EsiCKapGzbjxkNKlxVLMiLEnSFNTLBX1TGAkbWpllCH9KDKeW1vg
pxIi0Rne2Do1B6xiL+IFQ9nMipVOUIrcWn9mOGuGK6g6MSnuqnZOsjGXpFGvSF1Jjh4YKqg9
mkCZZMRB0nc3UNQaJVbV26yPMsmKed/XzSPuXt0oE24fo+etIDh13vPQF1D4jFpzofnRtEEg
UjQoVOi7K+cEXfw7mG/2h7f1UyDLvd5/tI5YLM0XxVw6J2ke2kMyDyEWpXOEXSceuhVhq6Vh
u6nhpa22bJWnKXFvJ0YwYsS1Wz7OaDSxZzqmSa3p59JnovfsoxZjlT6PIyzvH5ung2MILwOY
xtpHpSpDeGZpFgCxEk0SzXBD2YCogNGnawAjpm8iuRcTwHc5ycnFNB/rEY6lDXSGFJ6CW2BU
uSEqMpSa42qCDGE3IGZKrYS3VDbzIJWlsDakTbhpI85ARjCYfzcG+uIGIomFG0HThq6aQ0XS
ienjrPaZd7MsAAsmPW2fkkQ0zPEZg7xDeQbRq2Q1zBepT6iYrqTlX47KeVJ3WxVRNgGbkpH/
1CdMFgiW30GCtUMgVfZIYkiCgmYoIt6qzsdZLhgWpuUxLVAiRlwtqi4mtNeZhmTKRDFG0nn1
5MJWr9MW2bGiYXFOEl/nHBp8RBxqekRcenoezPZKOkI4QVLSeOWBIeL2ILkfOqtx0yBlR+vS
jrTE3+H/y26GF8v13qC6TFfYYbtCr30ykMxXhAvlqynO0MQDTRNfC1wWLexYp6HfToamVZ6H
U6IPDD0MaNqwYGGXCTNAktPwqoW1jUPoV6bQvQzCtuLWJ2/7zcNj2aUll92So3OOCzJua9zp
Xk6cmTem4Ku6Z3WqTmJwrvYtk1YKYcYimr8oGkpfCXFGe8p1HjdPUFqMeoO+dXyRJHjgcfNL
j3CUuE8AlgP3pnCCxNgJ6EAxohBeu2N3Av8TN7SArtQphFdwjPRxF7B4OaaLIk74AijA2L7/
cbeTOr/9utsHP9abffDft/KtrK9tGEKqO8R2aC+1ZxzftYlTNW7EgTWv/O7JJDQKIS5vi8pc
lcrYUakid4mDOo7bxIlTaiRtG3Ci0xT4zYBCA3e8QSBSUVjU5m2itPIMskUA007TiCzbQDWP
Vx56mxwv2rR8OHCUl3PhpoZtsuAJxaSRZQeH8vXQUgqIPCckvYS/QINgB0rLU3GU4W15MI76
jVTNk1tEOWMrkHkxRDyNGhu+l7Vzl6OEfvesD+XZjyb6ToNCon1f5fCz3OsGf+r3AlgQ/V6P
/bk5fLa7XRW3NgIYtc4PpkiIFSOeSxoyhxifeZbCnKQRz4ohpGoX8XPwaaa+QLg/5dUVt6rV
6u1p8wKL93nz9B5sjxPm33PR1ag8oW6jOhV95+FrNd/NG1dA9OyzIRaN+v2+His3HiGhCNZR
dxZDDOo+2bhy3+auz3Z9oqNJ5t7GJURk3N07AmSzazFMXup2DBCKSsKox9wOZoXvdGrUH95i
12aKBhS3DrqOJO+e9wkHDSeFWlDpcxEnxlF/cOtl0EcQRbYEays9jkhSeevZ+yaCYu++eA7J
c4rds6t8t+rnFBXZlKakc31Clae1aVx2JKnnoCJKBm53Tvq+1xKpHA1HniPtKYJ4d+qe6BVJ
wN/GnnOIbNQPb32D3L/1DOTsdpR4BCo64enwg7FyDBZdTtzxShxF1HNlWgg3IhLnXQghhGnJ
4bMO0vW+q1sOcNTxr1tageQqxU2ZmlYotfKU0Rd2dG7/bBLHMqq2w0wiN3gk9MisR39XD9V0
MEA8J1maR4cRyg/rS0vVb2FrxvRe+1P5+hrohfFpu9v+/nP9vF8/bHafm/Ybcnra3jlXu7/K
bZDpLXGHx1UdQaR7zWTYZ8skuDjHBcrFehtsTpfHrcoX9lqvg4Pn9aF82weZ7qLLU8Eic3eU
7iMUfNpsf+zX+/Lhs/NkIYvaV1nHT2/lYbc7/HSVGKt2PTJKgfXP1/fXQ/lsiQdEX3xvx9MK
5vDl52777rosC37bYdbo9uXt4L2dQFORn0898tdy/6SPo6xhNjlBwyAFszedLHohJMqXXlTi
jJC0WH7r9wZX3TyrbzfhyNxk10z/4Stg8ezCawYlG7iFknnd9EYhMncd2dUDR79y13H/BLHq
yoFrz5+DYzozGC9FiZWFVJ8FHfWuBtYpaEWGn03pDQ6sRgN80+91sAhIOcauq0NHGFMhB+dt
8aq3rWvP1jjNyKq6nnfpxIkCGS1UZfbjjICbbrSizbNUH7KkZKGcT2UM7TEfiVZvr+TAft6p
iR03nM86BvkWnnVpGc/xtNZTf4uo+S6qpgksxSxrK2Be/dd+8fBzvV/f642U1nXmuaFYc1Vd
beHmLg3k5ReapRco0bec6kfQmeMuU7nfrM0bLnbR0eC6Z+vwkdhRXQVXr4PcqnhiSbMiB/cm
v125RZClggSGtNucgjfTHECpGu++In8Uhbl5jGgQ24Ooz2tvR4VQK+kiQoE8Vd8G1+Hl4V31
NsnaGxInuZ6YxGfP9Emr4xUBqIHlV3JZqbVTxB3FvUHRvHR83M9l1NwfYxQcYhol9t4gUAWC
oBcsZONY5oxIBX2eNKA6Ua8fasUIN45hgWGG3ceTAC307mXEz09LFuvD/c+H3WOgH5cYCmnw
GYFATQMNX6AVz93mOVbuwpFnnyxSvkhF4JMgz9usuxzST6/k6iQfEtWpl4PkGe9koOObXs+P
jvq9QmHueS65hJBzEXU8/PEKDnvLpX/AILO5uYm78HBwM/Uz6OznuxeV+HrQatllZ+AGWgZd
tp6pJZSBq+z7JwIY+tfD6446+13DsUAxybwoFvm1p71gpjNYdtx6VZfOM+Tawmm8/Y2UZw85
G96G7r0NJCCXgkl395GnK9F+ZhXXV08h4Qt+PO1eXt6ru6ingLL2E9YLqKa9OdU9sa4HwKce
dnczNaY6MBZ1Yb7OA1q91vai6ZxGFHlhSKH9WPXi3N1tvedg3JsyDzXgo1BRvLTmFWgQPTJ3
QzSa9QcjP4giwlMvzCZ+ub4OsgWauz1MhhZQUh8/OJ8np5Pq5fv5Rfvx0hZ25CEDM1ga4AJP
ITqpgvVzIfT0uNtvDj+fX61y1Z8BGFtHh0eiwLFZfgoO5B/I6QL7iaJViGozYNy5OBGXwwYR
DM112KLpbUkzsddkkngSFsAg/O93gH3XdmIFSfu6O5DSauNy4JUmpjSBgL8RVNgsyJ91GHiR
0Mm0g4vS5ZUfzbhEc9+zAs1Rw1ddbgnhsb+4fpFwe92Fh553Ikf4Nlx64TlJEsJQ6pkXvdKf
GwTocVMl5pxHnA8d9xkNLZXl9nW3f4UsYPPiVldJ0vqJuREua4rU74Mgw+47A+4jhxzrbenn
dtlqJ9vjIo4sVI1uOhkSdnP9EcPoA4bR8COGj6pwvic5wTAz4ShErtGDAOVm5LtQfuFJbkbX
novpenaqi2lVZvEByzj/UMiUCveV4ufyYbN2bciBKyO8aCQX9dPmzePmAFnSfPNQ7oLxfrd+
uF9XB3CnF8mmnMh+QlM/g96vX35u7p3vvOOxZ9tdN0eSpPFC/vg3vkDTnyCY2Ly+6Be9dVDR
1vn5BLnSTBYhV45lHvkZxY6PU962D0ZqqLdsYC3UO4enP1eQbLZvv2rWAO3vf24O5b3+E09G
udR4ZAsf0MG7nKQYnJ25sGqgbolLIwHnUuq/B2IkpkCECB3CSoDsSgRmbeK55gqyxEDcWDtg
q8DxRm6ds1oXgjXqvsV+ev/u0LeqULODFjqnGaOezf+qt0qguRc9Jup5P7y+7vlliPzK9qjn
vzLgaTN49+ur675XIvquhkNPuKVxLK9C32uDGh6M/NJhzvu9mR+f8f9r7EqaW8WB8F9Jvdsc
phKwsfHhHTCLUcIWJGy/XFxM4sqkxgkpxznk349asg0CNXBIqtxfa0OtrVvdyleGaZgoQxKb
1gxF89ifmH3oYtaPWnjq0MOcRTjIwK0+YSj+Jw5Q7b/oFDrFDGfiq8akLzmfoo3J/G4A7+kV
aiwmdi88w+HY8eHWzARlCGJs1wcocX1j3tPjAjenOA5HHHuLt56f84i7JkvtnSs5UB3bFH6W
6vjdmqbZtbNE1Lkp6BIbXxzaOYXOzpJ+7j/OsyvtmECkEj2Du1ydhFBaZ23gxGaFoVjEE+ft
63l/OJQf+4ofAyCvjoeHTAwqrEC5JAn0JT+ubwjm6SVS/kmcmLh89k7SnGprH1ZfJ1j1Tsfq
cOArXUffDvn4oUt2oeu1m5We6ZreA7iok13LO6v13UP59aWzZmg7SW12VPgsTVnYNoUqXOj8
LgpwY6TKF7Xpe5NIWZrzc0C79Wdyt3P1XA5zAmc5yBfkvo/pRZp8hHqY77dSbOYO5xVmNs9r
P8hHPS+/W4xis6xBtvsizmiYMr1cfr+XH3WErjpCTUi8v1Tp5BS1vzjhYkxs2PT5bBegdeKw
boMqakK8m2XFqdmxOlXP1QETW8xwJMQR1YwLeSQZ8x9QeOP0CcQDXFtFURFPK3YYXvg2czxt
w8l7+YrY2EWTPNfuE0DXSRLkto4coC4olPFWhxn/3w4ucq1c/5FDTH7OEhjbicVZYyo31Bd/
P+DZ71/4RhtCu2izb/sPAtPl0mD5Un6eqq5AuA5z8W5zNn7P1J35KzQSG+A5i2zDwj8//2vd
O7xWWzQZkeGC0rl6Feia7GyO42sFT3hSDkVqx3esmnWnKQseUgU/JjMTbRdHzRmKMrKK8FFW
+DndOBE+SnOSWj0iHfmrlMF4wtemPFqvevDI9XpyxzHmU31frsqX1/1JdwUDkq0cb6URggBi
lMm7Hkrkambu1F3GmbTbOozp1Kocn3STTPqS3C8bNnv+Q66eNSn3CRcgnoGa7ZUstLg6i8SF
QcSzIEnQuN9w38kOKFlKyZZvBfQCAxyYPx9g4EZFwDiv5LsVJemiaJKEFxY0Tsp5GstqXSmP
RcoUJdAjhIJb61RnEmlcgRZpZRzv2hhQsBSrj8SmsnwpNiKgx6239oR8dMSD0HQxm90pkSvv
04g07wc/caYmLn8rSQovkL+lAiilt4HDbvn5TFtoAP5QjU8UU55CoazbLAm7fNbaisV0nanC
+aZ7VP/af79UIqJfp2KdIJ6C8KBa9PmOotV6SYmFsb5pZxFkTNw4mrG2BF+J6EhjcaYmCQs+
GUTLQL+onNFd1lKIX80rcd1t6jyufqCGSbkjfDUW4FiIQ0u/B8MhHxsFrmxVQ1TW256KZTj2
mGynOAqR+TGs6CRTHBLEXE3b4pe05Ap+ryeK5RYo+qM5QNIfUj1l1bCn5Ox1s/Z68vbAp0+T
L0QG9prvDPCfMmJD/XRCmrNms2iR5GrYeknZrahWYxAvW6MEKEkEQytwigixiROkZxI3wzrN
TT0Hw8QBMvafnlJc+rVdnpXH05twHmM/n+p+NnNyRiBA8zXkgm6NEZPjlfXq2lKe+D7rJio/
Xr/L13031HGiOO/UX+v3r7evyratxd/GryYMca1hlthNJ0pceQWbT/RmGZVJNc3oWGzrDi3D
RnSCLSZrDNOI2tpI4MwWkzGGaUzFZ5MxTNMxTGM+ARIVrcW0GGZaTEbktLDuxuQ04jstpiPq
ZM/x78Q3KSDlO3s4G8McU23OZSByfSnLaAv1BTAHqzkZ5BhuqjXIMRvkmA9yLAY5jOHGGMOt
MfDmPKTE3uX9cIH0VcECu/HKCt/maGP18J1fAJ4ejUNMKmlXG98DeKgcbv4tn/9rBQqXRtUH
8LPDYpMAA81IAgumDCGvqW/AdzI+P9JcLn023hMICGja42zXfr9HPEOQ8fWC1sbI/bN83ajq
xpOmvlvkRFW5Svz483mqXqUltqvClqGBG28hid+7UHGkPxOTovn4z5kYe1MNzerQaOgow6om
Y4apmsNSzRwq7jUDBZxpS+H6RENNgWyTAtJbop9nmFHqzOL4tA+GKEPWEMOsr03SWUhTfZ2u
IXr751gef26O1ffp7WOvdK/b9MV9isgSjt+REmVEUOsilWeC+J4l99W3FcSe739nZs5u7GsA
AA==

--YiEDa0DAkWCtVeE4--
