Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRACSOO>; Wed, 3 Jan 2001 13:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129485AbRACSOF>; Wed, 3 Jan 2001 13:14:05 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:43013 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S129226AbRACSNv>;
	Wed, 3 Jan 2001 13:13:51 -0500
Date: Wed, 3 Jan 2001 18:43:19 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Benchmarking 2.2 and 2.4 using hdparm and dbench 1.1
Message-ID: <Pine.LNX.4.21.0101031755090.4448-200000@svea.tellus>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811484-1327722195-978543799=:4448"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811484-1327722195-978543799=:4448
Content-Type: TEXT/PLAIN; charset=US-ASCII

I have been torturing a couple of boxes and came up with these benchmark
results.  I have also enclosed the script used to do the benchmark, and I
am well aware that this is a very specialized benchmark, testing only
limited parts of the kernel, and so on, BUT I am convinced that I'm seeing
something interesting things in the results anyway.  :-)

There are numbers for two different machines, and each test has been run
five times in succession, with a sync and a sleep in between.  The kernels
were optimized for Pentium Classic, and only contained IDE support (e.g.
no SCSI, networking, etc).  The only processes running besides the
benchmark script were kernel daemons and getty:s.  Both machines had
plenty of swap space available.

There are some numbers that I think are interesting:

1) Why does the hdbench numbers go down for 2.4 (only) when 32 MB is used?
   I fail to see how that matters, especially for the '-T' test.

2) The 2.4 kernels outperform the 2.2 kernels for many clients (see
   the "dbench 10" numbers).  This matters a lot.  Great!

3) The 2.2 kernels outperform the 2.4 kernels for few clients (see
   especially the "dbench 1" numbers for the PII-128M.  Oops!

The reason for doing the benchmarks in the first place is that my 32MB P90
at home really does perform noticeably worse with samba using 2.4 kernels
than using 2.2 kernels, and that bugs me.  I have no hard numbers for that
machine (yet).  If they will show anything extra, I will post them here.  
Btw, has anyone else noticed samba slowdowns when going from 2.2 to 2.4?

Anyway, any help explaining/fixing points 1 and 3 would be highly
appreciated!

/Tobias


[All numbers in MB/s, bigger are better.]
======================================================================
133 MHz Pentium, DMA, 80M

2.2.16-22:
hdparm -T	37.43	37.43	37.32	37.32	37.43
hdparm -t	6.08	6.14	6.15	6.10	6.08
dbench 1	10.4302	10.0796	10.2559	10.2258	13.5464
dbench 5	7.97753	8.13792	7.66108	7.8526	7.44329
dbench 10	5.78309	5.58762	5.76388	5.54761	5.94415

2.2.18:
hdparm -T	37.87	37.87	37.65	37.54	37.65
hdparm -t	6.04	6.04	6.10	6.11	6.07
dbench 1	9.98084	9.19558	10.1023	9.78034	10.7593
dbench 5	7.5335	7.85761	7.90051	8.19119	7.78873
dbench 10	5.98423	5.99556	5.84676	6.02366	5.87104

2.2.19pre3:
hdparm -T	37.98	37.43	37.21	37.43	37.87
hdparm -t	6.08	6.08	6.06	6.11	6.09
dbench 1	10.2117	11.2996	12.017	11.3003	12.1677
dbench 5	6.51203	6.80555	6.46566	6.66772	6.56693
dbench 10	5.55781	5.68997	5.43493	5.58688	5.32528

2.4.0-prerelease:
hdparm -T	38.21	38.21	38.32	38.21	38.21
hdparm -t	6.07	6.24	6.14	6.30	6.26
dbench 1	4.23029	3.89185	10.27	14.2546	14.2719
dbench 5	8.63648	9.21302	11.0506	9.64396	10.8724
dbench 10	7.12402	6.92772	8.02011	7.65119	8.12557

======================================================================
133 MHz Pentium, DMA, 32M

2.2.16-22:
hdparm -T	37.10	37.76	37.98	37.54	37.32
hdparm -t	6.01	6.04	6.07	5.93	6.06
dbench 1	10.0048	8.59813	8.49598	9.59796	9.04642
dbench 5	3.99638	4.59673	4.08813	3.90389	4.30821
dbench 10	2.6141	2.69585	2.63201	2.59543	2.61565

2.2.18:
hdparm -T	37.21	37.98	37.98	37.98	37.76
hdparm -t	5.94	5.98	6.03	6.05	6.03
dbench 1	9.66983	10.3501	9.77682	9.44597	10.0551
dbench 5	5.32253	5.31517	5.9542	5.83028	5.22383
dbench 10	2.86753	2.85903	2.83746	2.93299	2.84175

2.2.19pre3:
hdparm -T	36.99	38.21	37.98	37.87	37.10
hdparm -t	6.08	6.15	6.14	6.14	6.14
dbench 1	8.64248	7.73716	7.42123	7.6462	9.58718
dbench 5	4.57973	4.5689	4.32196	4.50044	4.68734
dbench 10	2.56748	2.55824	2.56042	2.54797	2.59391

2.4.0-prerelease:
hdparm -T	37.32	37.21	37.32	37.32	37.21
hdparm -t	5.87	5.70	5.34	5.09	5.07
dbench 1	4.41358	7.43094	8.76442	8.64346	9.45806
dbench 5	4.42467	4.22284	4.89167	4.48322	5.08206
dbench 10	4.19795	5.6161	4.09045	4.09799	4.55435




======================================================================
400 MHz Mobile Pentium II, UDMA(33), mem=128M

2.2.18:
hdparm -T	82.05	82.05	82.05	82.05	82.05
hdparm -t	9.85	9.82	10.09	10.08	9.83
dbench 1	45.8926	48.1175	47.7244	47.7418	47.457
dbench 5	18.4021	20.7948	22.3345	20.4869	14.2627
dbench 10	13.1219	10.0275	10.8189	13.7482	9.51982

2.2.19pre3:
hdparm -T	81.53	82.05	82.05	82.05	82.05
hdparm -t	9.88	9.89	9.86	9.88	9.85
dbench 1	38.752	43.6587	43.1486	41.004	42.4516
dbench 5	26.6624	27.4806	26.1421	28.9142	24.6634
dbench 10	14.9424	14.6862	14.2302	14.6954	14.8282

2.4.0-prerelease:
hdparm -T	82.05	83.12	83.12	83.12	83.12
hdparm -t	10.08	10.08	10.08	10.08	10.09
dbench 1	29.6794	27.1372	27.3597	28.8273	28.9547
dbench 5	24.1114	38.7179	40.103	45.52	42.1053
dbench 10	22.8095	23.7791	22.8248	23.779	22.7847

2.4.0-prerelease + prerelease-diff(153405 bytes):
hdparm -T	82.58	83.66	83.66	83.66	83.66
hdparm -t	10.08	10.08	10.09	10.08	10.08
dbench 1	27.3103	24.7335	24.8461	24.9076	24.8722
dbench 5	16.1611	18.2355	23.6982	30.9935	31.9133
dbench 10	19.2254	24.7655	26.2663	19.8009	19.7665

======================================================================
400 MHz Mobile Pentium II, UDMA(33), mem=32M

2.2.18:
hdparm -T	82.58	84.77	82.05	79.50	82.05
hdparm -t	8.98	9.51	9.22	9.58	9.52
dbench 1	25.3272	25.6109	22.1329	18.9078	18.9356
dbench 5	7.763	7.41623	8.4115	7.65282	9.06259
dbench 10	3.02379	2.90191	2.9487	2.89583	3.08329

2.2.19pre3:	
hdparm -T	82.05	84.77	82.05	80.00	82.05
hdparm -t	9.73	10.09	10.09	10.08	10.08
dbench 1	18.7016	16.0438	15.5598	14.9187	15.2902
dbench 5	7.14069	6.06751	6.51646	6.29517	6.20749
dbench 10	2.66164	2.64706	2.69115	2.64923	2.6574

2.4.0-prerelease:
hdparm -T	78.05	77.11	77.11	77.11	77.11
hdparm -t	9.41	8.67	8.48	8.29	9.12
dbench 1	4.9607	6.48172	6.62942	13.9923	15.4526
dbench 5	11.7028	14.0598	12.8747	10.9084	10.1008
dbench 10	6.03911	8.74155	11.0197	10.933	8.88914

2.4.0-prerelease + prerelease-diff(153405 bytes):
hdparm -T	78.05	77.11	77.11	77.11	77.11
hdparm -t	7.57	8.52	9.01	9.16	8.80
dbench 1	6.33322	14.6779	14.0875	16.5845	17.2773
dbench 5	7.0134	8.10417	7.76335	8.9227	11.3496
dbench 10	9.23498	9.09144	8.05864	7.87996	9.95048


Wow!  You made it all the way down here.  Congratulations!  :-)

---1463811484-1327722195-978543799=:4448
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=bench
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0101031843190.4448@svea.tellus>
Content-Description: 
Content-Disposition: attachment; filename=bench

IyEvYmluL3NoDQoNCkxPRz0vcm9vdC9iZW5jaC1gdW5hbWUgLXJgLnR4dA0K
REVWPS9kZXYvaGRhMw0KDQplY2hvICI9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0iIDI+JjEgfCB0ZWUgLWEgJExPRw0KZWNo
byAiVGVzdCBiZWdpbnMuLi4iIDI+JjEgfCB0ZWUgLWEgJExPRw0KZWNobyAi
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09IiAy
PiYxIHwgdGVlIC1hICRMT0cNCmVjaG8gIlJ1bm5pbmcgYHVuYW1lYCBgdW5h
bWUgLXJgIiAyPiYxIHwgdGVlIC1hICRMT0cNCmZyZWUgMj4mMSB8IHRlZSAt
YSAkTE9HDQpoZHBhcm0gJERFViAyPiYxIHwgdGVlIC1hICRMT0cNCmVjaG8g
Ij09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSIg
Mj4mMSB8IHRlZSAtYSAkTE9HDQoNCnJ1bigpIHsNCglzeW5jDQoJc2xlZXAg
MTANCgllY2hvICIjIyMjIyMjIyMjIyMjIyMjIyMjIyBSdW5uaW5nICQqIiAy
PiYxIHwgdGVlIC1hICRMT0cNCglldmFsICQqIDI+JjEgfCB0ZWUgLWEgJExP
Rw0KfQ0KDQp1bW91bnQgJERFViA+IC9kZXYvbnVsbCAyPiYxDQpta2UyZnMg
JERFViAyPiYxIDI+JjEgfCB0ZWUgLWEgJExPRw0KbW91bnQgJERFViAvZXhw
b3J0DQpjZCAvZXhwb3J0DQpjcCAvcm9vdC9kYmVuY2ggL3Jvb3QvY2xpZW50
LnR4dCAuDQoNCnJ1biBoZHBhcm0gLVQgJERFVg0KcnVuIGhkcGFybSAtVCAk
REVWDQpydW4gaGRwYXJtIC1UICRERVYNCnJ1biBoZHBhcm0gLVQgJERFVg0K
cnVuIGhkcGFybSAtVCAkREVWDQoNCnJ1biBoZHBhcm0gLXQgJERFVg0KcnVu
IGhkcGFybSAtdCAkREVWDQpydW4gaGRwYXJtIC10ICRERVYNCnJ1biBoZHBh
cm0gLXQgJERFVg0KcnVuIGhkcGFybSAtdCAkREVWDQoNCnJtIC1yZiBDTElF
TlRTIE5CU0lNVUxEIDsgcnVuIC4vZGJlbmNoIDENCnJtIC1yZiBDTElFTlRT
IE5CU0lNVUxEIDsgcnVuIC4vZGJlbmNoIDENCnJtIC1yZiBDTElFTlRTIE5C
U0lNVUxEIDsgcnVuIC4vZGJlbmNoIDENCnJtIC1yZiBDTElFTlRTIE5CU0lN
VUxEIDsgcnVuIC4vZGJlbmNoIDENCnJtIC1yZiBDTElFTlRTIE5CU0lNVUxE
IDsgcnVuIC4vZGJlbmNoIDENCg0Kcm0gLXJmIENMSUVOVFMgTkJTSU1VTEQg
OyBydW4gLi9kYmVuY2ggNQ0Kcm0gLXJmIENMSUVOVFMgTkJTSU1VTEQgOyBy
dW4gLi9kYmVuY2ggNQ0Kcm0gLXJmIENMSUVOVFMgTkJTSU1VTEQgOyBydW4g
Li9kYmVuY2ggNQ0Kcm0gLXJmIENMSUVOVFMgTkJTSU1VTEQgOyBydW4gLi9k
YmVuY2ggNQ0Kcm0gLXJmIENMSUVOVFMgTkJTSU1VTEQgOyBydW4gLi9kYmVu
Y2ggNQ0KDQpybSAtcmYgQ0xJRU5UUyBOQlNJTVVMRCA7IHJ1biAuL2RiZW5j
aCAxMA0Kcm0gLXJmIENMSUVOVFMgTkJTSU1VTEQgOyBydW4gLi9kYmVuY2gg
MTANCnJtIC1yZiBDTElFTlRTIE5CU0lNVUxEIDsgcnVuIC4vZGJlbmNoIDEw
DQpybSAtcmYgQ0xJRU5UUyBOQlNJTVVMRCA7IHJ1biAuL2RiZW5jaCAxMA0K
cm0gLXJmIENMSUVOVFMgTkJTSU1VTEQgOyBydW4gLi9kYmVuY2ggMTANCg0K
Y2QgLw0KdW1vdW50ICRERVYNCg==
---1463811484-1327722195-978543799=:4448--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
